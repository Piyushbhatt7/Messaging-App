import 'package:chatt_app/data/models/chat_room_model.dart';
import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:chatt_app/data/services/service_locator.dart';
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
    final otherUserId = chat.participants.firstWhere(
      (id) => id != currentUserId,
    );

    return chat.participantsName![otherUserId] ?? "Unknow";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Text(_getOtherUsername()[0].toUpperCase()),
      ),

      title: Text(
        _getOtherUsername(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      trailing: StreamBuilder<int>(stream: getIt<ChatRepository>().getUnreadCount(chat.id, currentUserId), builder: (context, snapshot)
      {
        if(!snapshot.hasData || snapshot.data == 0)
        {
          return const SizedBox();
        }

        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),

          child: const Text(
            
          ),
        )
      })
    );
  }
}
