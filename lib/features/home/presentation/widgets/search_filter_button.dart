import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bloc/photo_bloc.dart';
import 'filter_bottom_sheet.dart';

class SearchFilterButton extends StatelessWidget {
  final TextEditingController searchController;
  final String? selectedOrientation;
  final String? selectedSize;
  final String? selectedColor;
  final void Function(String? orientation, String? size, String? color) onFilterApplied;

  const SearchFilterButton({
    super.key,
    required this.searchController,
    required this.selectedOrientation,
    required this.selectedSize,
    required this.selectedColor,
    required this.onFilterApplied,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () async {
        final photoBloc = context.read<PhotoBloc>();

        await showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => FilterBottomSheet(
            initialOrientation: selectedOrientation,
            initialSize: selectedSize,
            initialColor: selectedColor,
            onApply: (orientation, size, color) {
              if (searchController.text.isEmpty) return;

              onFilterApplied(orientation, size, color);

              photoBloc.add(
                FilterPhotosEvent(
                  orientation: orientation,
                  size: size,
                  color: color,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
