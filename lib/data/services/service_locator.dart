import 'package:chatt_app/data/repository/auth_repository.dart';
import 'package:chatt_app/data/repository/chat_repository.dart';
import 'package:chatt_app/data/repository/contact_repository.dart';
import 'package:chatt_app/logic/cubits/auth/auth_cubit.dart';
import 'package:chatt_app/logic/cubits/chat/chat_cubit.dart';
import 'package:chatt_app/router/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupServiceLocator () async {
  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => ContactRepository());
  getIt.registerLazySingleton(() => AuthCubit(authRepository: AuthRepository()));
  getIt.registerLazySingleton(() => ChatCubit(chatRepository: ChatRepository(), currentUserId: getIt<FirebaseAuth>().currentUser!.uid));
  getIt.registerLazySingleton(() => ChatRepository());
}