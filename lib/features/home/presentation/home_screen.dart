import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../data/course_data.dart';
import '../../course/presentation/course_display.dart';
import '../../../../core/widgets/app_card.dart';
import 'widgets/section_title.dart';
import 'widgets/category_chips.dart';
import 'widgets/continue_watching_list.dart';
import '../../course/data/course_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  // 🔹 Cursurile în progres (pentru Continue Watching)
  final List<CourseModel> continueWatchingCourses = [
    mockCourses[0],
    mockCourses[1],
  ];

  List<CourseModel> get filteredCourses {
    if (selectedCategory == 'All') return mockCourses;
    return mockCourses
        .where((c) => c.skills.contains(selectedCategory))
        .toList();
  }

  void onCategorySelected(String category) {
    setState(() => selectedCategory = category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('EduApp', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Sidra 👋',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Continue Watching
            const SectionTitle(title: 'Continue Watching', showAll: true),
            const SizedBox(height: 10),
            ContinueWatchingList(
              courses: continueWatchingCourses,
              onTapCourse: (course) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDisplay(course: course),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // 🔹 Categorii
            SectionTitle(title: 'Categories', showAll: false),
            const SizedBox(height: 10),
            CategoryChips(
              onCategorySelected: onCategorySelected,
              selected: selectedCategory,
            ),
            const SizedBox(height: 20),

            // 🔹 Top / Filtered Courses
            SectionTitle(
                title: selectedCategory == 'All'
                    ? 'Top Courses'
                    : '$selectedCategory Courses',
                showAll: false),
            const SizedBox(height: 10),

            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filteredCourses.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final c = filteredCourses[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CourseDisplay(course: c)),
                    ),
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.asset(c.image,
                                width: 130, height: 90, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textPrimary)),
                                const SizedBox(height: 4),
                                Text(c.subtitle,
                                    style: const TextStyle(
                                        fontSize: 8,
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
