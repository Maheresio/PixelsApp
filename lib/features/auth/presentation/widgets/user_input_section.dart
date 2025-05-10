import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/app_strings.dart';
import '../../utils/validation.dart';

class UserInputSection extends StatefulWidget {
  const UserInputSection({
    super.key,
    required this.emailController,
    required this.passController,
    this.onFieldSubmitted,
  });

  final TextEditingController emailController;
  final TextEditingController passController;
  final Function(String)? onFieldSubmitted;

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
          enableInteractiveSelection: true,
          autofillHints: const [AutofillHints.email],
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return TextFormField(
              autofillHints: const [AutofillHints.password],
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: passwordValidator,
              controller: widget.passController,
              decoration: InputDecoration(
                labelText: AppStrings.password,
                suffixIcon: IconButton(
                  icon:
                      isObscure
                          ? const Icon(FontAwesomeIcons.solidEyeSlash)
                          : const Icon(FontAwesomeIcons.solidEye),
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
