import 'package:equatable/equatable.dart';

enum ChatStatus { initaial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final String? error;
  final String? receiverId;
  final String? chatRoomId;

  ChatState({
    this.status = ChatStatus.initaial,
    this.error,
    this.receiverId,
    this.chatRoomId,
  });

  ChatState copyWith({
    ChatStatus? status,
    String? error,
    String? receiverId,
    String? chatRoomId,
  }) {
    return ChatState(
      status: status ?? this.status,
      error: error ?? this.error,
      receiverId: receiverId ?? this.receiverId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
    );
  }

  @override
  List<Object?> get props => [status, error, receiverId, chatRoomId];
}