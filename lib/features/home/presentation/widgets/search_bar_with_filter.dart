import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_strings.dart';
import '../controller/bloc/photo_bloc.dart';
import 'search_filter_button.dart';

class SearchBarWithFilter extends StatefulWidget {
  final String? selectedOrientation;
  final String? selectedSize;
  final String? selectedColor;
  final TextEditingController searchController;
  final void Function(String? orientation, String? size, String? color)
  onFilterApplied;

  const SearchBarWithFilter({
    super.key,
    required this.searchController,
    this.selectedOrientation,
    this.selectedSize,
    this.selectedColor,
    required this.onFilterApplied,
  });

  @override
  State<SearchBarWithFilter> createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 1.5.sw,
          child: TextField(
            controller: widget.searchController,
            enabled: state is! PhotoLoading,
            decoration: InputDecoration(
              suffixIcon: SearchFilterButton(
                searchController: widget.searchController,
                selectedOrientation: widget.selectedOrientation,
                selectedSize: widget.selectedSize,
                selectedColor: widget.selectedColor,
                onFilterApplied: widget.onFilterApplied,
              ),

              hintText: AppStrings.searchPhotos,
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<PhotoBloc>().add(SearchPhotosEvent(query: value));
              }
            },
            onChanged: (value) {
              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }

              _debounce = Timer(const Duration(seconds: 2), () {
                if (value.isNotEmpty) {
                  context.read<PhotoBloc>().add(
                    SearchPhotosEvent(query: value),
                  );
                }
              });
            },
          ),
        );
      },
    );
  }
}
