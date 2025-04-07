import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/app_colors.dart';
import 'shimmer_placeholder.dart';

class PhotoGridShimmer extends StatelessWidget {
  const PhotoGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.kPrimary.withValues(alpha: 0.2),
        highlightColor: AppColors.kPrimary.withValues(alpha: 0.4),
        child: MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.sizeOf(context).width > 500 ? 3 : 2,
          ),
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 14.0,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ShimmerPlaceholder(index);
          },
        ),
      ),
    );
  }
}

