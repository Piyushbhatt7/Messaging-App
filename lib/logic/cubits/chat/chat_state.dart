import 'package:chatt_app/data/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { initaial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final String? error;
  final String? receiverId;
  final String? chatRoomId;
  final List<ChatMessage> messages;
  final bool isReceiverTyping;
  final bool isReceiverOnline;
  final Timestamp? receiverLatSeen;
  final bool hasMoreMessages;
  final bool isLoadingMore;
  final bool isUserBlocked;
  final bool amIBlocked;

  ChatState copyWith({
    ChatStatus? status,
    String? error,
    String? receiverId,
    String? chatRoomId,
    List<ChatMessage>? messages,
    bool? isReceiverTyping,
    bool? isReceiverOnline, 
    Timestamp? receiverLatSeen,       
    bool? hasMoreMessages,       
    bool? isLoadingMore,  
    bool? isUserBlocked, 
    bool? amIBlocked,  
  }) {
    return ChatState(
      status: status ?? this.status,
      error: error ?? this.error,
      receiverId: receiverId ?? this.receiverId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      messages: messages ?? this.messages,
      isReceiverTyping: isReceiverTyping ?? this.isReceiverTyping,
      isReceiverOnline: isReceiverOnline ?? this.isReceiverOnline,
      receiverLatSeen: receiverLatSeen ?? this.receiverLatSeen,
      hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isUserBlocked: isUserBlocked ?? this.isUserBlocked,
      amIBlocked: amIBlocked ?? this.amIBlocked,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        receiverId,
        chatRoomId,
        messages,
        isReceiverTyping,
        isReceiverOnline,
        receiverLatSeen,
        hasMoreMessages,
        isLoadingMore,
        isUserBlocked,
        amIBlocked,
      ];

  ChatState({
    this.isReceiverTyping = false,
    this.isReceiverOnline = false,
    this.receiverLatSeen,
    this.hasMoreMessages = false,
    this.isLoadingMore = false,
    this.isUserBlocked = false,
    this.amIBlocked = false,
    this.status = ChatStatus.initaial,
    this.error,
    this.receiverId,
    this.chatRoomId,
    this.messages = const [],
  });

}
