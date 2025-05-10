import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_router.dart';
import '../../../../core/app_strings.dart';
import '../../../auth/presentation/controller/auth_provider.dart';

class LogoutFloatingButton extends ConsumerWidget {
  const LogoutFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          if (previous != next) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${AppStrings.logoutFailed} ${error.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        data: (user) {
          if (user == null && previous != next) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.logoutSuccessful),
                backgroundColor: Colors.green,
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (!context.mounted) return;
             context.go(AppRouter.loginView);
            });
          }
        },
      );
    });

    return FloatingActionButton(
      onPressed: () async {
        ref.read(authProvider.notifier).signOut();
      },
      child: const Icon(Icons.logout),
    );
  }
}
