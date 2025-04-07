import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.isLoading,
  });
  final void Function()? onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
