import 'package:flutter/services.dart';

import '../app_colors.dart';

void styledStatusBar() {
   SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.kPrimary,
      systemNavigationBarColor: AppColors.kPrimary,
      systemNavigationBarDividerColor: AppColors.kPrimary,
    ),
  );
}

