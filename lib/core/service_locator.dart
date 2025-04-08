import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pixels_app/features/auth/data/repository/auth_repository.dart';
import 'package:pixels_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pixels_app/features/auth/data/services/auth_service.dart';
import 'package:pixels_app/features/home/data/repository/home_repository.dart';

import '../features/home/data/repository/home_repository_impl.dart';
import 'services/api_service.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));
  sl.registerLazySingleton<AuthService>(() => AuthService());

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthService>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<ApiService>()),
  );
}
