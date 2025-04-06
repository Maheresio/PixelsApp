import 'package:flutter/material.dart';
import 'package:pixels_app/core/app_extensions.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: context.textStyles.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
