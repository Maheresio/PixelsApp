import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_router.dart';
import '../controller/auth_provider.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authNotifier.signOut();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout successful!'),
                  backgroundColor: Colors.green,
                ),
              );
              GoRouter.of(context).pushReplacement(AppRouter.loginView);
            }
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
