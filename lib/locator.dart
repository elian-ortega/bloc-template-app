import 'package:bloc_app_template/services/authentication_service.dart';
import 'package:bloc_app_template/services/dialog_service.dart';
import 'package:bloc_app_template/services/firestore_service.dart';
import 'package:bloc_app_template/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  locator.registerLazySingleton<DialogService>(() => DialogService());

  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());

  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
}
