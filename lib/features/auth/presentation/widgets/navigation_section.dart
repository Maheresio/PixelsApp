import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_extensions.dart';
import '../../../../core/app_router.dart';
import '../../../../core/app_strings.dart';

class NavigationSection extends StatelessWidget {
  const NavigationSection({super.key, this.isLogin = true});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          isLogin ? AppStrings.dontHaveAccount : AppStrings.alreadyHaveAccount,
        ),
        TextButton(
          onPressed: () {
            if (isLogin) {
              context.go(AppRouter.registerView);
            } else {
              context.go(AppRouter.loginView);
            }
          },
          child: Text(
            isLogin ? AppStrings.register : AppStrings.login,
            style: context.textStyles.bodyMedium?.copyWith(
              color: AppColors.kPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
