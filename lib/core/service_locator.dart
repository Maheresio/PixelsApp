import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/home/data/repository/home_repository_impl.dart';
import 'services/api_service.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // Register Dio
  sl.registerLazySingleton(() => Dio());

  // Register ApiService
  sl.registerLazySingleton(() => ApiService(sl<Dio>()));

  // Register HomeRepository
  sl.registerLazySingleton(() => HomeRepositoryImpl(sl<ApiService>()));
}
