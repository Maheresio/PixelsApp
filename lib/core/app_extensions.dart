import 'package:flutter/material.dart';

extension TextStyleExtensions on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}
