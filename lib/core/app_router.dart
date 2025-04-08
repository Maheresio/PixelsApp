import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixels_app/features/home/data/repository/home_repository.dart';

import '../features/auth/presentation/views/landing_view.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/home/presentation/controller/bloc/photo_bloc.dart';
import '../features/home/presentation/view/home_view.dart';
import 'service_locator.dart';

class AppRouter {
  static const String landingView = '/';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String homeView = '/home';
  
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
        path: AppRouter.homeView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => PhotoBloc(sl<HomeRepository>()),
              child: const HomeView(),
            ),
        pageBuilder:
            (context, state) => CustomTransitionPage(
              child: BlocProvider(
                create: (context) => PhotoBloc(sl<HomeRepository>()),
                child: const HomeView(),
              ),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
      ),
    ],
  );
}
