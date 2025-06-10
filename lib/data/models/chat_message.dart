import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, video }

enum MessageStatus { sent, read }

class ChatMessage {
  final String id;
  final String chatRoomId;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final Timestamp timestamp;
  final List<String> readBy;

  ChatMessage({
    required this.id,
    required this.chatRoomId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    required this.timestamp,
    required this.readBy,
  });

   factory ChatMessage.fromFirestore(DocumentSnapshot doc)
  {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      uid: doc.id, 
      username: data["username"] ?? "", 
      fullName: data["fullName"] ?? "", 
      email: data["email"] ?? "", 
      phoneNumber: data["phoneNumber"] ?? "", 
      fmcToken: data["fmcToken"],
      lastseen: data["lastSeen"]?? TimeOfDay.now(),
      createdAt: data["createdAt"]?? Timestamp.now(),
      blockedUsers: List<String>.from(data["blockedUsers"]),
      );
  }
}
