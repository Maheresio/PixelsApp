import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixels_app/core/app_router.dart';
import 'package:pixels_app/core/app_strings.dart';
import '../controller/auth_provider.dart';

class LandingView extends ConsumerWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStream = ref.watch(authRepositoryProvider).authStateChanges;

    return Scaffold(
      body: Center(
        child: StreamBuilder<User?>(
          stream: authStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                   '${AppStrings.anErrorOccurred}: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => {ref.refresh(authRepositoryProvider)},
                    child: const Text(AppStrings.retry),
                  ),
                ],
              );
            }

            
            Future.microtask(() {
              if (context.mounted) {
                final user = snapshot.data;
                if (user == null) {
                  GoRouter.of(context).pushReplacement(AppRouter.loginView);
                } else {
                  GoRouter.of(context).pushReplacement(AppRouter.homeView);
                }
              }
            });

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
