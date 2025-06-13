import 'package:chatt_app/data/models/chat_room_model.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final ChatRoomModel chat;
  final String currentUserId;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.chat,
    required this.currentUserId,
    required this.onTap,
  });

  String _getOtherUsername() {
    final otherUserId = chat.participants.firstWhere((id) => id != currentUserId);

    return chat.participantsName! [otherUserId] ?? "Unknow";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Text(_getOtherUsername()[0].toUpperCase()),
      ),

      title: Text(_getOtherUsername(), style: TextStyle(
        fontWeight: FontWeight.bold
      ),),

      subtitle: Text(chat.lastMessage ?? ""),
      trailing: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Text("3"),
      ),
    );
  }
}
