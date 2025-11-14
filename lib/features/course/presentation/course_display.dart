import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../controllers/home_controller.dart';
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
    final detail = _resolveDetail();
    final instructor = detail?['instructor'] is Map<String, dynamic>
        ? Map<String, dynamic>.from(detail?['instructor'])
        : null;
    final lessons = detail == null
        ? const <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(
            (detail['lessons'] as List?) ?? const []);
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
            if (detail != null) ...[
              const SizedBox(height: 30),
              const Text('Instructor',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              if (instructor != null)
                _InstructorCard(data: instructor),
              const SizedBox(height: 20),
              const Text('Lessons',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              ...lessons.map(_LessonTile.new),
            ],
          ],
        ),
      ),
    );
  }

  Map<String, dynamic>? _resolveDetail() {
    if (!Get.isRegistered<HomeController>()) return null;
    final detailsRoot = Get.find<HomeController>().detailsData;
    if (detailsRoot.isEmpty) return null;
    final detail = detailsRoot['course'];
    if (detail is Map<String, dynamic>) {
      final detailId = detail['id']?.toString();
      if (course.id != null && detailId == course.id) {
        return detail;
      }
      if (course.id == null &&
          (detail['title']?.toString() ?? '') == course.title) {
        return detail;
      }
    }
    return null;
  }
}

class _InstructorCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _InstructorCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              data['image'] ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.person, color: AppColors.textSecondary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name'] ?? '',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                Text(data['title'] ?? '',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Text(
                  data['bio'] ?? '',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final Map<String, dynamic> lesson;

  const _LessonTile(this.lesson);

  @override
  Widget build(BuildContext context) {
    final isPreview = lesson['isPreview'] == true;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Text(
              (lesson['id'] ?? '').toString().split('_').last.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10, color: AppColors.primary, letterSpacing: 0.5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lesson['title'] ?? '',
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(lesson['duration'] ?? '',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          if (isPreview)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: const Text('Preview',
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }
}
