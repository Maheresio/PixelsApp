import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/helpers/validation.dart';

class UserInputSection extends StatefulWidget {
  const UserInputSection({
    super.key,
    required this.emailController,
    required this.passController,
  });

  final TextEditingController emailController;
  final TextEditingController passController;

  @override
  State<UserInputSection> createState() => _UserInputSectionState();
}

class _UserInputSectionState extends State<UserInputSection> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        TextFormField(
          validator: emailValidator,

          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,

          controller: widget.emailController,
          decoration: const InputDecoration(labelText: AppStrings.email),
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return TextFormField(
              validator: passwordValidator,
              controller: widget.passController,
              decoration: InputDecoration(
                labelText: AppStrings.password,
                suffixIcon: IconButton(
                  icon:
                      isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                  onPressed:
                      () => setState(() {
                        isObscure = !isObscure;
                      }),
                ),
              ),

              obscureText: isObscure,
            );
          },
        ),
      ],
    );
  }
}
