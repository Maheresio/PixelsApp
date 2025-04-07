import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';

class HomeHeaderText extends StatelessWidget {
  const HomeHeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.exploreBeautifulPhotos,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
