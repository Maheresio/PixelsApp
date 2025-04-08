import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixels_app/features/auth/utils/utils.dart';

import '../../../../core/app_router.dart';
import '../../../../core/app_strings.dart';
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
    final authNotifier = ref.read(loginProvider.notifier);
    final authState = ref.watch(loginProvider);

    ref.listen<AsyncValue>(loginProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            successShowSnackBarAndNavigateTo(
              previous: previous,
              next: next,
              context: context,
              navigateTo:
                  () =>
                      GoRouter.of(context).pushReplacement(AppRouter.homeView),
              emailController: emailController,
              passController: passController,
              snackBarContent: AppStrings.loginSuccessful,
            );
          }
        },

        error: (error, _) {
          showErrorSnackBar(error: error, context: context, next: next);
        },
      );
    });
    final widthSize = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      
        child: Form(
          key: _formKey,
          child: Center(
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
                      onFieldSubmitted: (_) => _submit(context, authNotifier),
                    ),
                    const SizedBox(height: 40),
                    SubmitButton(
                      onPressed: () => _submit(context, authNotifier),
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
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, AuthStateNotifier authNotifier) {
    return submit(
      context: context,
      authNotifier: authNotifier,
      formKey: _formKey,
      emailController: emailController,
      passController: passController,
      isLogin: true,
    );
  }
}
