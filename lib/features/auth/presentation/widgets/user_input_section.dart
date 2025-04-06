import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/helpers/validation.dart';

class UserInputSection extends StatelessWidget {
  const UserInputSection({
    super.key,
    required this.emailController,
    required this.passController,
  });

  final TextEditingController emailController;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        TextFormField(
          validator: emailValidator,

          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          controller: emailController,
          decoration: const InputDecoration(labelText: AppStrings.email),
        ),
        TextFormField(
          validator: passwordValidator,
          controller: passController,
          decoration: const InputDecoration(labelText: AppStrings.password),
          obscureText: true,
        ),
      ],
    );
  }
}

