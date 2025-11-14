import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppChip extends StatelessWidget {
  final String label;

  const AppChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12)),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
