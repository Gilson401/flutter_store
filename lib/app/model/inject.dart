import 'package:flutter_store/app/model/auth_service.dart';
import 'package:flutter_store/app/model/http_client.dart';
import 'package:flutter_store/app/model/local_storage.dart';
import 'package:flutter_store/app/model/service.dart';
import 'package:get_it/get_it.dart';

final GetIt inject = GetIt.I;

Future<void> startModules() async {
  inject.registerSingleton<LocalStorage>(SharePreferencesImpl());
  inject.registerLazySingleton<HttpClient>(() => DioImpl());
  inject.registerSingleton<Service>(Service());
  inject.registerSingleton<AuthService>(AuthService());
  

}
