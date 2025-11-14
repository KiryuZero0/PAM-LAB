import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../course/presentation/course_display.dart';
import '../domain/entities/course_summary.dart';
import '../domain/usecases/get_feed.dart';
import 'controllers/feed_controller.dart';
import 'widgets/category_chips.dart';
import 'widgets/course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      FeedController(getFeedUseCase: Get.find<GetFeedUseCase>()),
    );

    void openCourse(CourseSummary course) {
      Get.to(() => CourseDisplay(course: course));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('EduApp'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshFeed,
          ),
        ],
      ),
      body: Obx(() {
        final status = controller.status.value;
        if (status == FeedStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (status == FeedStatus.error) {
          return _ErrorState(
            message: controller.errorMessage.value,
            onRetry: controller.refreshFeed,
          );
        }

        final feed = controller.feed;
        if (feed == null) {
          return const Center(child: Text('No data available'));
        }

        final continueWatching = controller.continueWatching;
        final suggestions = controller.suggestions;
        final topCourses = controller.topCourses;
        final categories = <String>[
          'All',
          ...controller.categories.map((e) => e.name),
        ];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${feed.user.name}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const _SectionTitle('Continue Watching'),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: continueWatching.length,
                  itemBuilder: (_, index) {
                    final item = continueWatching[index];
                    return _ContinueWatchingCard(
                      summary: item,
                      onTap: () => openCourse(item),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const _SectionTitle('Categories'),
              const SizedBox(height: 8),
              Obx(() {
                return CategoryChips(
                  categories: categories,
                  selected: controller.selectedCategory.value,
                  onCategorySelected: controller.selectCategory,
                );
              }),
              const SizedBox(height: 20),
              const _SectionTitle('Suggestions'),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestions.length,
                  itemBuilder: (_, index) {
                    final item = suggestions[index];
                    return _SuggestionCard(
                      summary: item,
                      onTap: () => openCourse(item),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const _SectionTitle('Top Courses'),
              const SizedBox(height: 10),
              if (topCourses.isEmpty)
                const Text('No top courses available')
              else
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topCourses.length,
                    itemBuilder: (_, index) {
                      final item = topCourses[index];
                      return _SuggestionCard(
                        summary: item,
                        onTap: () => openCourse(item),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              const _SectionTitle('Explore Courses'),
              const SizedBox(height: 10),
              Obx(() {
                final items = controller.exploreCourses;
                if (items.isEmpty) {
                  return const Text('No courses available for this category.');
                }
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      final course = items[index];
                      return CourseCard(
                        title: course.title,
                        subtitle: course.institute,
                        image: course.image,
                        rating: course.rating,
                        onTap: () => openCourse(course),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.summary, required this.onTap});

  final CourseSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                summary.image,
                height: 120,
                width: 180,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 120,
                  width: 180,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              summary.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              summary.institute,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Row(
              children: [
                const Icon(Icons.star, size: 12, color: Colors.amber),
                const SizedBox(width: 4),
                Text(summary.rating.toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueWatchingCard extends StatelessWidget {
  const _ContinueWatchingCard({required this.summary, required this.onTap});

  final CourseSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final progress = summary.progress ?? 0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                summary.image,
                height: 100,
                width: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              summary.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              '$progress% completed',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Failed to load feed',
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
