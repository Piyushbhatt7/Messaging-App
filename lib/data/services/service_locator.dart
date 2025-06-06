import 'package:chatt_app/router/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupServiceLocator () async {
  getIt.registerLazySingleton(() => AppRouter());
  
}