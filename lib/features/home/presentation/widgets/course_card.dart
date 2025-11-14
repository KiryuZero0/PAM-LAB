import 'package:flutter/material.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_colors.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final double rating;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget placeholder() {
      return Container(
        width: 130,
        height: 90,
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image, color: AppColors.textSecondary),
      );
    }

    Widget buildImage(String path) {
      if (path.startsWith('http')) {
        return Image.network(
          path,
          width: 130,
          height: 90,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return placeholder();
          },
          errorBuilder: (_, __, ___) => placeholder(),
        );
      }
      return Image.asset(
        path,
        width: 130,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder(),
      );
    }

    return SizedBox(
      width: 130,
      child: AppCard(
        onTap: onTap,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: buildImage(image),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 8,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
