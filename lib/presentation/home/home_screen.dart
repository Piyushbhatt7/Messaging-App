import 'package:chatt_app/data/repository/auth_repository.dart';
import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:chatt_app/data/repository/contact_repository.dart';
import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/logic/cubits/auth/auth_cubit.dart';
import 'package:chatt_app/presentation/chat/chat_message_screen.dart';
import 'package:chatt_app/presentation/screens/auth/login_screen.dart';
import 'package:chatt_app/presentation/widgets/chat_list_tile.dart';
import 'package:chatt_app/router/app_router.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ContactRepository _contactRepository;
  late final ChatRepository _chatRepository;
  late final String _currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contactRepository = getIt<ContactRepository>();
    _chatRepository = getIt<ChatRepository>();
    _currentUserId = getIt<AuthRepository>().currentUser?.uid ?? "";
  }

  void _showContctList(BuildContext context) // 4:26
  {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Contacts",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _contactRepository.getRegisteredContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final contacts = snapshot.data!;

                    if (contacts.isEmpty) {
                      return const Center(child: Text("No contacts found"));
                    }
                    return ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.1),
                            child: Text(contact["name"][0]),

                            // child: Text(widget.receiverName[0].toUpperCase()),
                          ),
                          title: Text(contact["name"]),
                          onTap: () {
                            getIt<AppRouter>().push(
                              ChatMessageScreen(
                                receiverId: contact['id'],
                                receiverName: contact['name'],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          InkWell(
            onTap: () async {
              await getIt<AuthCubit>().signOut();
              getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _chatRepository.getChatRooms(_currentUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!;

          if (chats.isEmpty) {
            return Center(child: Text("No recent Chats!"));
          }
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ChatListTile(
                chat: chat,
                currentUserId: _currentUserId,
                onTap: () {
                  final otherUserId = chat.participants.firstWhere((id) => id != _currentUserId);
                  final otherUserName = chat.participantsName ! [otherUserId] ?? "Unknow";
                  getIt<AppRouter>().push(ChatMessageScreen(receiverId: otherUserId, receiverName: otherUserName));
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContctList(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.chat_rounded, color: Colors.white),
      ),
    );
  }
}
