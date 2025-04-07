import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixels_app/core/app_colors.dart';

import '../../../../core/app_strings.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(String? orientation, String? size, String? color) onApply;
  final String? initialOrientation;
  final String? initialSize;
  final String? initialColor;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    this.initialOrientation,
    this.initialSize,
    this.initialColor,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedOrientation;
  String? selectedSize;
  String? selectedColor;

  void clearFilters() {
    setState(() {
      selectedOrientation = null;
      selectedSize = null;
      selectedColor = null;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedOrientation = widget.initialOrientation;
    selectedSize = widget.initialSize;
    selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderWidget(),
          const SizedBox(height: 16),
          _FilterSectionWidget(
            title: AppStrings.orientation,
            options: const [
              AppStrings.any,
              AppStrings.portrait,
              AppStrings.landscape,
            ],
            selectedValue: selectedOrientation,
            onSelect: (value) => setState(() => selectedOrientation = value),
          ),
          const SizedBox(height: 16),
          _FilterSectionWidget(
            title: AppStrings.size,
            options: const [
              AppStrings.any,
              AppStrings.small,
              AppStrings.medium,
            ],
            selectedValue: selectedSize,
            onSelect: (value) => setState(() => selectedSize = value),
          ),
          const SizedBox(height: 16),
          _ColorFilterSectionWidget(
            selectedColor: selectedColor,
            onColorSelected:
                (colorHex) => setState(
                  () =>
                      selectedColor =
                          selectedColor == colorHex ? null : colorHex,
                ),
          ),
          const SizedBox(height: 24),
          _ActionButtonsWidget(
            onClear: clearFilters,
            onApply: () {
              widget.onApply(selectedOrientation, selectedSize, selectedColor);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.filters,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
    );
  }
}

class _FilterSectionWidget extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onSelect;

  const _FilterSectionWidget({
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
  });

  void _updateSelection(String option) {
    final isSelected = selectedValue == option;
    onSelect(isSelected ? null : option);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              options
                  .map(
                    (option) => _OptionChipWidget(
                      label: option,
                      isSelected: selectedValue == option,
                      onSelect: () => _updateSelection(option),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class _OptionChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const _OptionChipWidget({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip.elevated(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(),
      selectedColor: Colors.blue.shade100,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(color: isSelected ? Colors.blue : Colors.black),
    );
  }
}

class _ColorFilterSectionWidget extends StatelessWidget {
  final String? selectedColor;
  final Function(String) onColorSelected;

  const _ColorFilterSectionWidget({
    required this.selectedColor,
    required this.onColorSelected,
  });

  static const Map<String, Color> colorMap = {
    'black': Colors.black,
    'red': Colors.red,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'blue': Colors.blue,
    'indigo': Colors.indigo,
    'purple': Colors.purple,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.color),
        const SizedBox(height: 8),
        Row(
          children:
              colorMap.entries
                  .map(
                    (entry) => _ColorCircleWidget(
                      color: entry.value,
                      colorHex: entry.key,
                      isSelected: selectedColor == entry.key,
                      onSelect: () => onColorSelected(entry.key),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class _ColorCircleWidget extends StatelessWidget {
  final Color color;
  final String colorHex;
  final bool isSelected;
  final VoidCallback onSelect;

  const _ColorCircleWidget({
    required this.color,
    required this.colorHex,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: CircleAvatar(backgroundColor: color, radius: 14),
      ),
    );
  }
}

class _ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onApply;

  const _ActionButtonsWidget({required this.onClear, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: onClear,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.kPrimary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            AppStrings.clear,
            style: TextStyle(
              color: AppColors.kPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.kPrimary),
          child: const Text(AppStrings.apply),
        ),
      ],
    );
  }
}
