import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_router.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_styles.dart';
import '../controller/auth_provider.dart';
import '../widgets/overlay_loading_indicator.dart';

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
              return const OverlayLoadingIndicator();
            }

            if (snapshot.hasError) {
              debugPrint('Auth error in LandingView: ${snapshot.error}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.kErrorColor,
                      size: 48.sp,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '${AppStrings.anErrorOccurred}: ${snapshot.error}',
                      style: AppStyles.text14Medium.copyWith(
                        color: AppColors.kErrorColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => ref.refresh(authRepositoryProvider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimary,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: Text(
                        AppStrings.retry,
                        style: AppStyles.text14Medium.copyWith(
                          color: AppColors.kwhite,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Defer navigation to after build
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

            return const Center(child: OverlayLoadingIndicator());
          },
        ),
      ),
    );
  }
}
