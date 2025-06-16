import 'package:chatt_app/data/models/chat_message.dart';
import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/logic/cubits/chat/chat_cubit.dart';
import 'package:chatt_app/logic/cubits/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController messageController = TextEditingController();
  late final ChatCubit _chatCubit;

  @override
  void initState() {
    _chatCubit = getIt<ChatCubit>();
    _chatCubit.enterChat(widget.receiverId);
    // TODO: implement initState
    super.initState();
  }

  Future<void> _handleSendMessage() async {
    final messageText = messageController.text.trim();
    messageController.clear();
    await _chatCubit.sendMessage(
      content: messageText,
      receiverId: widget.receiverId,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    _chatCubit.leaveChat();
    super.dispose();
  }

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

                 BlocBuilder<ChatCubit, ChatState>(
                  bloc: getIt<ChatCubit>(),
                  builder: (context, state)
                 {
                  if(state.isReceiverTyping)
                  {
                    return Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4),
                          child: const Text('Typing...'),
                        ),

                        Text("typing...", style: TextStyle(
                          color: Theme.of(context).primaryColor
                        ),)
                      ],
                    );
                  }

                  if(state.isReceiverOnline)
                  {
                    return Text("Online", style: TextStyle(color: Colors.lightGreenAccent),);
                  }

                  
                  if(state.receiverLatSeen != null)
                  {
                    final lastSeen = state.receiverLatSeen !.toDate();
                    return Text("last seen at ${DateFormat('h:mm a').format(lastSeen)}", style: TextStyle(color: Colors.lightGreenAccent),);
                  }
                 })
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

      body: BlocBuilder<ChatCubit, ChatState>(
        bloc: _chatCubit,
        builder: (context, state) {
          if (state.status == ChatStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ChatStatus.error) {
            Center(child: Text(state.error ?? "Something went wrong"));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    final isMe = message.senderId == _chatCubit.currentUserId;
                    return MessageBubble(message: message, isMe: isMe); // 5:28
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
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onTap: () {},
                            controller: messageController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            // maxLines: ,
                            decoration: InputDecoration(
                              hintText: "Type of message",
                              filled: true,

                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Theme.of(context).cardColor,
                            ),
                          ),
                        ),

                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: _handleSendMessage,
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
          color: isMe ? Theme.of(context).primaryColor : Color(0xffF7CFD8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(message.timestamp.toDate()),
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black,
                    fontSize: 12,
                  ),
                ),

                //    const SizedBox(width: 54,),
                if (isMe) ...[
                  const SizedBox(width: 4.0,),
                  Icon(
                    message.status == MessageStatus.read
                        ? Icons.check
                        : Icons.done_all,
                    size: 14,
                    color:
                        message.status == MessageStatus.read
                            ? Colors.lightBlueAccent
                            : Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
