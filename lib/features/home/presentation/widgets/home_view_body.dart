import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_colors.dart';
import 'home_header_text.dart';
import 'photo_grid_view.dart';
import 'search_bar_with_filter.dart';

class HomeViewBody extends StatelessWidget {
  final ScrollController scrollController;
  final TextEditingController searchController;
  final String? selectedOrientation;
  final String? selectedSize;
  final String? selectedColor;
  final void Function(String?, String?, String?) onFilterApplied;

  const HomeViewBody({
    super.key,
    required this.scrollController,
    required this.searchController,
    required this.selectedOrientation,
    required this.selectedSize,
    required this.selectedColor,
    required this.onFilterApplied,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.kPrimary, Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width > 1200 ? 120.w : 16.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            SearchBarWithFilter(
              selectedOrientation: selectedOrientation,
              selectedSize: selectedSize,
              selectedColor: selectedColor,
              searchController: searchController,
              onFilterApplied: onFilterApplied,
            ),
            const SizedBox(height: 16.0),
            const HomeHeaderText(),
            const SizedBox(height: 16.0),
            const PhotoGridView(),
          ],
        ),
      ),
    );
  }
}
