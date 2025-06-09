import 'package:chatt_app/data/repository/contact_repository.dart';
import 'package:chatt_app/data/services/service_locator.dart';
import 'package:chatt_app/logic/cubits/auth/auth_cubit.dart';
import 'package:chatt_app/presentation/screens/auth/login_screen.dart';
import 'package:chatt_app/router/app_router.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final ContactRepository _contactRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contactRepository = getIt<ContactRepository>();
  }

  void _showContctList(BuildContext context) // 4:26
  {
    showModalBottomSheet(context: context, builder: (context)
    {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Contacts", style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: _contactRepository.getRegisteredContacts(), 
              builder: (context, snapshot)
              {
                if(snapshot.hasError)
                {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }

                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final contacts = snapshot.data!;

                if(contacts.isEmpty)
                {
                  return const Center(
                    child: Text(
                      "No contacts found"
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index)
                {

                })
              }
              )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Chats"),
      actions: [
        InkWell(
          onTap: () async{
           await getIt<AuthCubit>().signOut();
           getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
          },
          child: Icon(Icons.logout))
      ],
    ),
      body: Center(
        child: Text("Home screen"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {

      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.chat_rounded, color: Colors.white,),
      ),
    );
  }
}