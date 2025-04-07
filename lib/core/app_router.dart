import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixels_app/core/services/api_service.dart';
import 'package:pixels_app/features/auth/presentation/views/profile_view.dart';
import 'package:pixels_app/features/auth/presentation/views/login_view.dart';
import 'package:pixels_app/features/auth/presentation/views/register_view.dart';
import 'package:pixels_app/features/home/data/repository/home_repository_impl.dart';
import 'package:pixels_app/features/home/presentation/controller/bloc/photo_bloc.dart';

import '../features/auth/presentation/views/landing_view.dart';
import '../features/home/presentation/view/home_view.dart';

class AppRouter {
  static const String landingView = '/';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String homeView = '/home';
  static const String profileView = '/profile';
  static final GoRouter router = GoRouter(
    initialLocation: landingView,
    routes: [
      GoRoute(
        path: AppRouter.landingView,
        builder: (context, state) => const LandingView(),
      ),
      GoRoute(
        path: AppRouter.loginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRouter.registerView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRouter.profileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: AppRouter.homeView,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => PhotoBloc(HomeRepositoryImpl(ApiService(Dio()))),
              child: const HomeView(),
            ),
      ),
    ],
  );
}
