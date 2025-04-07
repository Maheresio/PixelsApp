import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_router.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/error/failure.dart';
import '../controller/auth_provider.dart';
import '../widgets/header_text.dart';
import '../widgets/navigation_section.dart';
import '../widgets/social_section.dart';
import '../widgets/submit_button.dart';
import '../widgets/user_input_section.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.watch(authProvider.notifier);
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue>(authProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            emailController.clear();
            passController.clear();

            if (previous != next) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppStrings.loginSuccessful),
                  backgroundColor: Colors.green,
                ),
              );
            }
            GoRouter.of(context).go(AppRouter.homeView);
          }
        },
        loading: () {},
        error: (error, _) {
          final errorMessage =
              error is Failure ? error.message : error.toString();
          if (previous != next) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.kPrimary,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      );
    });
    final widthSize = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),

          child: Form(
            key: _formKey,
            child: Builder(
              builder: (context) {
                return Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width:
                          widthSize > 1200
                              ? widthSize * .3
                              : widthSize > 600
                              ? widthSize * .6
                              : widthSize,
                      child: Column(
                        children: [
                          const HeaderText(title: AppStrings.login),
                          const SizedBox(height: 100),
                          UserInputSection(
                            emailController: emailController,
                            passController: passController,
                          ),
                          const SizedBox(height: 40),
                          SubmitButton(
                            onPressed:
                                authState.isLoading
                                    ? null
                                    : () {
                                      if (_formKey.currentState!.validate()) {
                                        authNotifier.signInWithEmail(
                                          emailController.text,
                                          passController.text,
                                        );
                                      }
                                    },
                            text: AppStrings.login,
                            isLoading: authState.isLoading,
                          ),
                          const NavigationSection(),
                          const SizedBox(height: 20),
                          SocialSection(authNotifier: authNotifier),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
