import 'package:get_it/get_it.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton(() => SessionManager());
}
