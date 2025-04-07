import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: (index % 3 + 1) * 100.0,
        color: AppColors.kPrimary.withValues(alpha: 0.2),
      ),
    );
  }
}
