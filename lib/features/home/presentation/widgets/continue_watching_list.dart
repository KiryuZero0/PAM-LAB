import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../course/data/course_model.dart';

class ContinueWatchingList extends StatelessWidget {
  final List<CourseModel> courses;
  final Function(CourseModel)? onTapCourse;

  const ContinueWatchingList({
    super.key,
    this.onTapCourse,
    this.courses = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Text(
        'No courses in progress',
        style: TextStyle(color: AppColors.textSecondary),
      );
    }

    return Column(
      children: courses.map((course) {
        return GestureDetector(
          onTap: () => onTapCourse?.call(course),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(course.image,
                      width: 80, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.title,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(course.subtitle,
                          style: const TextStyle(
                              fontSize: 10, color: AppColors.primary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
