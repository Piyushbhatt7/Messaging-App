import 'package:equatable/equatable.dart';

enum ChatStatus { initaial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final String? error;
  final String? receiverId;

  ChatState({
    this.status = ChatStatus.initaial,
    this.error,
    this.receiverId,
  });

  ChatState copyWith({
    ChatStatus? status,
    String? error,
    String? receiverId,
  }) {
    return ChatState(
      status: status ?? this.status,
      error: error ?? this.error,
      receiverId: receiverId ?? this.receiverId,
    );
  }

  @override
  List<Object?> get props => [status, error, receiverId];
}