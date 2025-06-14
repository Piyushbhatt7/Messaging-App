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
  final bool? isLoadingMore;
  final bool? isUserBlocked;
  final bool? amIBlocked;


  ChatState(this.isReceiverTyping, this.isReceiverOnline, this.receiverLatSeen, this.hasMoreMessages, this.isLoadingMore, this.isUserBlocked, this.amIBlocked, {
    this.status = ChatStatus.initaial,
    this.error,
    this.receiverId,
    this.chatRoomId,
    this.messages = const [],
  });

  ChatState copyWith({
    ChatStatus? status,
    String? error,
    String? receiverId,
    String? chatRoomId,
    List<ChatMessage>? message,
  }) {
    return ChatState(
      status: status ?? this.status,
      error: error ?? this.error,
      receiverId: receiverId ?? this.receiverId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      messages: message ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [status, error, receiverId, chatRoomId, messages];
}