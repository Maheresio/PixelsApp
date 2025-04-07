import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixels_app/core/app_colors.dart';

class StyledSocialButton extends StatelessWidget {
  const StyledSocialButton({super.key, this.onTap});

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: 90,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: .5,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTap,
          splashColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.1),
          child: const Center(
            child: Icon(FontAwesomeIcons.google, color: AppColors.kPrimary),
          ),
        ),
      ),
    );
  }
}
