import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:flutter/widgets.dart';

class AppLifeCycleObsever extends WidgetsBindingObserver{

  final String userId;
  final ChatRepository chatRepository;

  AppLifeCycleObsever({required this.userId, required this.chatRepository});
}

