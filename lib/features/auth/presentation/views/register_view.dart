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

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
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
    final authNotifier = ref.read(registerProvider.notifier);
    final authState = ref.watch(registerProvider);
    final widthSize = MediaQuery.sizeOf(context).width;

    ref.listen<AsyncValue>(registerProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            successShowSnackBarAndNavigateTo(
              previous: previous,
              next: next,
              context: context,
              navigateTo: () => GoRouter.of(context).push(AppRouter.loginView),
              snackBarContent: AppStrings.registerSuccessful,
              emailController: emailController,
              passController: passController,
            );
          }
        },
        error: (error, _) {
          showErrorSnackBar(
            error: error,
            context: context,
            previous: previous,
            next: next,
          );
        },
      );
    });

    final contentWidth =
        widthSize > 1200
            ? widthSize * 0.3
            : widthSize > 600
            ? widthSize * 0.6
            : widthSize;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const HeaderText(title: AppStrings.register),
                      const SizedBox(height: 100),
                      UserInputSection(
                        emailController: emailController,
                        passController: passController,
                        onFieldSubmitted:
                            (_) => _submit(context, authNotifier),
                      ),
                      const SizedBox(height: 40),
                      SubmitButton(
                        onPressed: () => _submit(context, authNotifier),
                        text: AppStrings.register,
                        isLoading: authState.isLoading,
                      ),
                      const NavigationSection(isLogin: false),
                      const SizedBox(height: 20),
                      SocialSection(authNotifier: authNotifier),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, AuthStateNotifier authNotifier) {
    submit(
      context: context,
      authNotifier: authNotifier,
      formKey: _formKey,
      emailController: emailController,
      passController: passController,
      isLogin: false,
    );
  }
}
