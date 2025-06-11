import 'package:chatt_app/data/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessageScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const ChatMessageScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {

  final  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Text(widget.receiverName[0].toUpperCase()),
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.receiverName),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: ChatMessage(
                    id: "2344545",
                    chatRoomId: "99r8r88r",
                    senderId: "64443333",
                    receiverId: "66455yy",
                    content: "Hell this is demo chat",
                    timestamp: Timestamp.now(),
                    readBy: [],
                    status: MessageStatus.sent,
                  ),
                  isMe: false,
                ); // 5:28
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    
                Icon(Icons.emoji_emotions),
                                const SizedBox(width: 8,),
                    Expanded(
                      child: TextField(
                        onTap: () {
                          
                        },
                        controller: messageController,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                       // maxLines: ,
                        decoration: InputDecoration(
                          hintText: "Type of message",
                          filled: true,
                          
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Theme.of(context).cardColor
                        ),
                      ),
                    ),
            
                    SizedBox(width: 8.0,),
                    IconButton(onPressed: (){
            
                    }, icon: Icon(Icons.send, color: Theme.of(context).primaryColor,))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  // final bool showTime;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    // required this.showTime,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isMe ? 64 : 8,
          right: isMe ? 8 : 64,
          bottom: 4,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isMe
                  ? Theme.of(context).primaryColor
                  : Color(0xffF7CFD8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "22:55 PM",
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),

                Icon(
                  Icons.done_all,
                  color:
                      message.status == MessageStatus.read
                          ? Colors.red
                          : Colors.white70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
