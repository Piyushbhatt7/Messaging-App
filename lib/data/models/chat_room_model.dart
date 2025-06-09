import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {

  final String id;
  final List<String> participants;
  final String? lastMessage;
  final String lastMessageSenderId;
  final Timestamp? lastMessageTime;
  final Map<String, Timestamp>? lastRead;
}