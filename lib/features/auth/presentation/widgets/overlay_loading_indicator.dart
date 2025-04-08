import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_colors.dart';

class OverlayLoadingIndicator extends StatelessWidget {
  const OverlayLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: const AlwaysStoppedAnimation(AppColors.kPrimary),
      strokeWidth: 4.w, 
      backgroundColor: AppColors.kPrimary.withValues(alpha: 0.2), 
    );
  }
}
