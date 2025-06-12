import 'dart:async';

import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:chatt_app/logic/cubits/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  final String currentUserId;

  StreamSubscription? _messageSubscription;

  ChatCubit({
    required ChatRepository chatRepository,
    required this.currentUserId,
  }) : _chatRepository = chatRepository, super(ChatState());


  void enterChat(String reciverId) async{
    emit(state.copyWith(status: ChatStatus.loading));

    try {
      final chatRoom = await _chatRepository.getOrCreateChatRoom(currentUserId, reciverId);
      emit(state.copyWith(chatRoomId: chatRoom.id, receiverId: reciverId, status: ChatStatus.loaded));
      
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, error: "Failed to create chat room $e"));
    }
  }
  Future<void>sendMessage({

    required String content,
    required String receiverId
  }) async{

    if(state.chatRoomId == null)
    
      return;
    

    try {
      await _chatRepository.sendMessage(
        chatRoomId: state.chatRoomId!, 
        senderId: currentUserId,
        receiverId: receiverId, 
        content: content
        );
    } catch (e) {
      emit(state.copyWith(error: "Failed to send message"));
    }
  }

  void _subscribeToMessages(String chatRoomId)
  {
    _messageSubscription?.cancel(); // 6:20
    _messageSubscription = _chatRepository.getMessages(chatRoomId).listen((messages)
    {
       emit(state.copyWith(
        message: messages, 
        error: null,
       ));
    }, onError: (error)
    {
      emit(state.copyWith(error: "Failed to load messages", status: ChatStatus.error));
    });
  }
}
