import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool showAll;
  final VoidCallback? onSeeAll;

  const SectionTitle({
    super.key,
    required this.title,
    this.showAll = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.9,
            )),
        if (showAll) ...[
          const Spacer(),
          InkWell(
            onTap: onSeeAll,
            child: const Text(
              'See All',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                decoration: TextDecoration.underline,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
