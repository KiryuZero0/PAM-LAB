import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SkillChip extends StatelessWidget {
  final String label;

  const SkillChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      backgroundColor: Colors.white,
    );
  }
}
