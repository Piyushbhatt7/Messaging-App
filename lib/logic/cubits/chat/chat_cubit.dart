import 'dart:async';

import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:chatt_app/logic/cubits/chat/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  final String currentUserId;
  bool _isInChat = false;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _onlineStatusSubscription;
  StreamSubscription? _typingSubscription;

  ChatCubit({
    required ChatRepository chatRepository,
    required this.currentUserId,
  }) : _chatRepository = chatRepository, super(ChatState());


  void enterChat(String reciverId) async{

    _isInChat = true;

    emit(state.copyWith(status: ChatStatus.loading));

    try {
      final chatRoom = await _chatRepository.getOrCreateChatRoom(currentUserId, reciverId);
      emit(state.copyWith(chatRoomId: chatRoom.id, receiverId: reciverId, status: ChatStatus.loaded));

      _subscribeToMessages(chatRoom.id);
      
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

      if(_isInChat)
      {
        _markMessagesAsRead(chatRoomId);
      }

       emit(state.copyWith(
        message: messages, 
        error: null,
       ));
    }, onError: (error)
    {
      emit(state.copyWith(error: "Failed to load messages", status: ChatStatus.error));
    }); // 6:31
  }

  void _subscribeToOnlineStatus(String userId) {

    _onlineStatusSubscription?.cancel();
    _onlineStatusSubscription = _chatRepository.getUserOnlineStatus(userId).listen((status) {

      final isOnline = status["isOnline"] as bool;
      final lastSeen = status["lastSeen"] as Timestamp?;
      
      emit(state.copyWith(
        isReceiverOnline: isOnline,
        receiverLatSeen: lastSeen,
      ));
    },
    onError: (error)
    {
      print("error getting online status");
    }
    );
  }

  Future<void> _markMessagesAsRead(String chatRoomId) async {

    try {
      await _chatRepository.markMessagesAsRead(chatRoomId, currentUserId);
    } catch (e) {
      print("Error marking messages as read $e");
    }
  }

  Future<void> leaveChat() async {
    _isInChat = false;
  }
}
