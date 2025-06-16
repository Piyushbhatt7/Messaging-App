import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:flutter/widgets.dart';

class AppLifeCycleObsever extends WidgetsBindingObserver{

  final String userId;
  final ChatRepository chatRepository;

  AppLifeCycleObsever({required this.userId, required this.chatRepository});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state)
    {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      chatRepository.updateOnlineStatus(userId, false);
      break;

      case AppLifecycleState.resumed:
      chatRepository.updateOnlineStatus(userId, true);
    }
  }
}

