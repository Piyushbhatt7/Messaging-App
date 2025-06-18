import 'package:chatt_app/data/models/chat_message.dart';
import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/logic/cubits/chat/chat_cubit.dart';
import 'package:chatt_app/logic/cubits/chat/chat_state.dart';
import 'package:chatt_app/presentation/widgets/loading_dosts.dart';
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
  bool _isComposing = false;
  List<ChatMessage> _previousMessages;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _chatCubit = getIt<ChatCubit>();
    _chatCubit.enterChat(widget.receiverId);
    messageController.addListener(_onTextChanged);
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

  void _onTextChanged() {
    final isComposing = messageController.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
      });

      if (isComposing) {
        _chatCubit.startTyping();
      }
    }
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

                // Text(
                //   "Online",
                //   style: TextStyle(color: Colors.green, fontSize: 12),
                // ),
                BlocBuilder<ChatCubit, ChatState>(
                  bloc: _chatCubit,
                  builder: (context, state) {
                    if (state.isReceiverTyping) {
                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: const LoadingDots(),
                          ),

                          Text(
                            "typing",
                            style: TextStyle(
                              color: Color(0xffF7CFD8), // 8:23
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      );
                    }

                    if (state.isReceiverOnline) {
                      return Text(
                        "Online",
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontSize: 12.0,
                        ),
                      );
                    }

                    if (state.receiverLatSeen != null) {
                      final lastSeen = state.receiverLatSeen!.toDate();
                      return Text(
                        "last seen at ${DateFormat('h:mm a').format(lastSeen)}",
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontSize: 12.0,
                        ),
                      );
                    }

                    return SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          BlocBuilder<ChatCubit, ChatState>(
            bloc: _chatCubit,
            builder: (context, state) {
              if (state.isUserBlocked) {
                return TextButton.icon(
                  onPressed: () => _chatCubit.unBlockUser(widget.receiverId),
                  label: Text("Unblock"),
                  icon: Icon(Icons.block),
                );
              }
              return PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (value) async {
                  if (value == "block") {
                    final bool? confirm = await showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text(
                              "Are you sure you wan to block ${widget.receiverName}",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),

                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(
                                  "Block",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );

                    if (confirm == true) {
                      await _chatCubit.blockUser(widget.receiverId); // 8:44
                    }
                  }
                },
                itemBuilder:
                    (context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        value: 'block',
                        child: Text("Block")),
                    ],
              );
            },
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
              if(state.amIBlocked)
              Container(
                color: Colors.redAccent.withOpacity(0.1),
                padding: EdgeInsets.all(8.0),
                child: Text("You have been blocked by ${widget.receiverName}", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),),
              ),
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
              if(!state.amIBlocked && !state.isUserBlocked)
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
                          onPressed: _isComposing? _handleSendMessage : null,
                          icon: Icon(
                            Icons.send,
                            color: _isComposing?  Theme.of(context).primaryColor : Colors.blueGrey,
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
                  const SizedBox(width: 4.0),
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
