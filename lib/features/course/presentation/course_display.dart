import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../course/data/course_model.dart';
import 'widgets/skill_chip.dart';
import 'widgets/stat_row.dart';

class CourseDisplay extends StatelessWidget {
  final CourseModel course;

  const CourseDisplay({super.key, required this.course});

  /// 🧠 Funcție inteligentă care alege între asset și network automat
  Widget loadImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Text(
              'Image not found',
              style: TextStyle(color: Colors.black54),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        path,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Text(
              'Missing asset',
              style: TextStyle(color: Colors.black54),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(course.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: loadImage(course.image),
            ),
            const SizedBox(height: 20),
            Text(course.subtitle,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.star, color: AppColors.primary, size: 18),
                  const SizedBox(width: 5),
                  Text(course.rating.toString(),
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textPrimary)),
                ]),
                Text('\$${course.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Course Details',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(course.description,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 20),
            const Text('Statistics',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            StatRow(
                icon: Icons.video_library,
                title: 'Lectures',
                value: '${course.lectures}+'),
            StatRow(
                icon: Icons.timer,
                title: 'Duration',
                value: '${course.weeks} Weeks'),
            StatRow(
                icon: Icons.verified,
                title: 'Certificate',
                value: course.certificateType),
            const SizedBox(height: 20),
            const Text('Skills You\'ll Gain',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: course.skills.map((s) => SkillChip(s)).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: AppButton(
                label: 'ENROLL NOW',
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Start your 7-day free trial',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
