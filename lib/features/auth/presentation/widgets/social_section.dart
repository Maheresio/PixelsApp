import 'package:flutter/material.dart';
import 'package:pixels_app/features/auth/presentation/controller/auth_provider.dart';

import '../../../../core/app_strings.dart';
import 'styled_social_button.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key, required this.authNotifier});

  final AuthStateNotifier authNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider()),
            Text(AppStrings.orLoginWith),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 20),
        StyledSocialButton(onTap: () => authNotifier.signInWithGoogle()),
      ],
    );
  }
}
