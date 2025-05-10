import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../../../core/error/failure.dart';
import '../presentation/controller/auth_provider.dart';

void showErrorSnackBar({
  required Object error,
  required BuildContext context,
  AsyncValue<dynamic>? previous,
  required AsyncValue<dynamic> next,
}) {
  if (error is FirebaseAuthException) debugPrint(error.code);
  final errorMessage = error is Failure ? error.message : error.toString();
  if (previous != next) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.kPrimary,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

void successShowSnackBarAndNavigateTo({
  AsyncValue<dynamic>? previous,
  required AsyncValue<dynamic> next,
  required BuildContext context,
  required VoidCallback navigateTo,
  required String snackBarContent,
  required TextEditingController emailController,
  required TextEditingController passController,
}) {
  emailController.clear();
  passController.clear();
  if (previous != next) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarContent),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  Future.delayed(const Duration(seconds: 1), () {
    if (context.mounted) {
      navigateTo();
    }
  });
}


void submit({
  required BuildContext context,
  required AuthStateNotifier authNotifier,
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
  required TextEditingController passController,
  required bool isLogin,
}) {
  FocusScope.of(context).unfocus();
  if (formKey.currentState!.validate()) {
    if (isLogin) {
      authNotifier.signInWithEmail(
        emailController.text.trim(),
        passController.text,
      );
    } else {
      authNotifier.registerWithEmail(
        emailController.text.trim(),
        passController.text,
      );
    }
  }
}
