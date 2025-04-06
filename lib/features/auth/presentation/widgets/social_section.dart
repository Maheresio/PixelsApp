import 'package:flutter/material.dart';
import 'package:pixels_app/features/auth/presentation/controller/auth_provider.dart';

import 'styled_social_button.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key, required this.authNotifier});

  final AuthStateNotifier authNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider()),
            const Text('Or login with'),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 20),
        StyledSocialButton(onTap: () => authNotifier.signInWithGoogle()),
      ],
    );
  }
}
