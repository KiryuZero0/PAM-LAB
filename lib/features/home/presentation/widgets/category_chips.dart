import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;
  final String selected;

  const CategoryChips({
    super.key,
    required this.onCategorySelected,
    required this.selected,
    this.categories = const ['All', 'Typography', 'Branding', 'UI Design', 'Editorial Design'],
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: categories.map((c) {
        final isSelected = c == selected;
        return ChoiceChip(
          label: Text(
            c,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontSize: 12,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onCategorySelected(c),
          selectedColor: AppColors.primary,
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(color: AppColors.border),
          ),
        );
      }).toList(),
    );
  }
}
