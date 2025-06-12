import 'package:chatt_app/data/models/chat_message.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { initaial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final String? error;
  final String? receiverId;
  final String? chatRoomId;
  final List<ChatMessage> message;

  ChatState({
    this.status = ChatStatus.initaial,
    this.error,
    this.receiverId,
    this.chatRoomId,
    this.message = const [],
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
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, error, receiverId, chatRoomId, message];
}