import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../home/domain/entities/course_summary.dart';
import '../domain/entities/course_details.dart';
import '../domain/usecases/get_course_details.dart';
import 'controllers/course_details_controller.dart';
import 'widgets/skill_chip.dart';
import 'widgets/stat_row.dart';

class CourseDisplay extends StatefulWidget {
  const CourseDisplay({super.key, required this.course});

  final CourseSummary course;

  @override
  State<CourseDisplay> createState() => _CourseDisplayState();
}

class _CourseDisplayState extends State<CourseDisplay> {
  late final CourseDetailsController controller;

  @override
  void initState() {
    super.initState();
    final tag = widget.course.id;
    if (Get.isRegistered<CourseDetailsController>(tag: tag)) {
      Get.delete<CourseDetailsController>(tag: tag, force: true);
    }
    controller = Get.put(
      CourseDetailsController(
        courseId: widget.course.id,
        getCourseDetailsUseCase: Get.find<GetCourseDetailsUseCase>(),
      ),
      tag: tag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<CourseDetailsController>(tag: widget.course.id)) {
      Get.delete<CourseDetailsController>(tag: widget.course.id, force: true);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(course.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        final status = controller.status.value;
        final details = controller.details.value;
        if (status == CourseDetailsStatus.loading && details == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status == CourseDetailsStatus.error && details == null) {
          return _CourseError(
            message: controller.errorMessage.value,
            onRetry: controller.fetchDetails,
          );
        }
        return _CourseBody(
          summary: course,
          details: details,
          isLoadingDetails: status == CourseDetailsStatus.loading,
          onRetry: controller.fetchDetails,
        );
      }),
    );
  }
}

class _CourseBody extends StatelessWidget {
  const _CourseBody({
    required this.summary,
    this.details,
    required this.isLoadingDetails,
    required this.onRetry,
  });

  final CourseSummary summary;
  final CourseDetails? details;
  final bool isLoadingDetails;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final imagePath = details?.thumbnail ?? summary.image;
    final rating = details?.rating ?? summary.rating;
    final price = details?.price;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildImage(imagePath),
          ),
          const SizedBox(height: 20),
          Text(
            summary.institute,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.primary, size: 18),
                  const SizedBox(width: 5),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                price != null ? '\$${price.toStringAsFixed(0)}' : 'Coming soon',
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SectionLabel('Course Details'),
          const SizedBox(height: 8),
          Text(
            details?.description ??
                'Detailed description will be available once the course is fully loaded.',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          const _SectionLabel('Statistics'),
          const SizedBox(height: 10),
          StatRow(
            icon: Icons.video_library,
            title: 'Lectures',
            value: '${details?.lectures ?? '--'}+',
          ),
          StatRow(
            icon: Icons.timer,
            title: 'Duration',
            value: details?.duration ?? '--',
          ),
          StatRow(
            icon: Icons.verified,
            title: 'Certificate',
            value: details?.certification ?? '--',
          ),
          const SizedBox(height: 20),
          const _SectionLabel('Skills You\'ll Gain'),
          const SizedBox(height: 10),
          if (details?.skills.isNotEmpty == true)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: details!.skills
                  .map((skill) => SkillChip(skill))
                  .toList(),
            )
          else if (isLoadingDetails)
            const Center(child: CircularProgressIndicator())
          else
            const Text(
              'Skill information is not available for this course yet.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          const SizedBox(height: 30),
          Center(
            child: AppButton(
              label: 'ENROLL NOW',
              onPressed: details == null ? onRetry : () {},
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Start your 7-day free trial',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          if (details != null) ...[
            const SizedBox(height: 30),
            const _SectionLabel('Instructor'),
            const SizedBox(height: 10),
            _InstructorCard(instructor: details!.instructor),
            const SizedBox(height: 20),
            const _SectionLabel('Lessons'),
            const SizedBox(height: 10),
            if (details!.lessons.isEmpty)
              const Text(
                'Lessons will be announced soon.',
                style: TextStyle(color: AppColors.textSecondary),
              )
            else
              ...details!.lessons.map(_LessonTile.new),
          ],
        ],
      ),
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imagePlaceholder,
      );
    }
    return Image.asset(
      path,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imagePlaceholder,
    );
  }

  Widget get _imagePlaceholder => Container(
    width: double.infinity,
    height: 200,
    color: Colors.grey[300],
    alignment: Alignment.center,
    child: const Text(
      'Image not available',
      style: TextStyle(color: Colors.black54),
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _InstructorCard extends StatelessWidget {
  const _InstructorCard({required this.instructor});

  final Instructor instructor;

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
              instructor.image,
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
                Text(
                  instructor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  instructor.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  instructor.bio,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
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
  const _LessonTile(this.lesson);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Text(
              lesson.id.split('_').last.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.primary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lesson.duration,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (lesson.isPreview)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CourseError extends StatelessWidget {
  const _CourseError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Unable to load course details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
