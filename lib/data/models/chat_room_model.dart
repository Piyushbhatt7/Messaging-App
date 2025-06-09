import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {

  final String id;
  final List<String> participants;
  final String? lastMessage;
  final String lastMessageSenderId;
  final Timestamp? lastMessageTime;
  final Map<String, Timestamp>? lastReadTime;
  final Map<String, String>? participantsName;
  final bool isTyping;
  final String? isTypingUserId;
  final bool isCallActive;

  ChatRoomModel({required this.id, required this.participants, required this.lastMessage, required this.lastMessageSenderId, required this.lastMessageTime, required this.lastReadTime, required this.participantsName, required this.isTyping, required this.isTypingUserId, required this.isCallActive});
}