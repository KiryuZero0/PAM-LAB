import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2/features/controllers/home_controller.dart';
import 'package:lab2/features/controllers/course_controller.dart';
import 'package:lab2/features/course/presentation/course_display.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final courseController = Get.put(CourseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("EduApp"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.homeData;
        if (data.isEmpty) {
          return const Center(child: Text("No data loaded"));
        }

        final Map<String, dynamic> user =
            Map<String, dynamic>.from(data["user"] ?? <String, dynamic>{});
        final continueWatching = List<Map<String, dynamic>>.from(
            (data["continueWatching"] as List?) ?? const []);
        final categories = List<Map<String, dynamic>>.from(
            (data["categories"] as List?) ?? const []);
        final suggestions = List<Map<String, dynamic>>.from(
            (data["suggestions"] as List?) ?? const []);
        final topCourses = List<Map<String, dynamic>>.from(
            (data["topCourses"] as List?) ?? const []);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome, ${user["name"]}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),
              const Text("Continue Watching",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              // Continue Watching list
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: continueWatching.length,
                  itemBuilder: (_, i) {
                    final c = continueWatching[i];
                    return GestureDetector(
                      onTap: () {
                        final title = c["title"]?.toString();
                        final id = c["id"]?.toString();
                        final match =
                            courseController.findCourse(id: id, title: title);
                        if (match != null) {
                          Get.to(() => CourseDisplay(course: match));
                        } else {
                          Get.snackbar(
                              'Course not found', 'No course details available');
                        }
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                c["image"],
                                height: 100,
                                width: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 100,
                                  width: 200,
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(c["title"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("${c["progress"]}% completed",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              const Text("Categories",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Obx(() {
                final selected = courseController.selectedCategory.value;
                final items = [
                  {"name": "All"},
                  ...categories,
                ];
                return Wrap(
                  spacing: 8,
                  children: items.map<Widget>((cat) {
                    final name = cat["name"].toString();
                    final isSelected = name == selected;
                    return ChoiceChip(
                      label: Text(name),
                      selected: isSelected,
                      onSelected: (_) =>
                          courseController.onCategorySelected(name),
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 20),
              const Text("Suggestions",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              // Suggestions
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestions.length,
                  itemBuilder: (_, i) {
                    final s = suggestions[i];
                    return GestureDetector(
                      onTap: () {
                        final title = s["title"]?.toString();
                        final id = s["id"]?.toString();
                        final match =
                            courseController.findCourse(id: id, title: title);
                        if (match != null) {
                          Get.to(() => CourseDisplay(course: match));
                        } else {
                          Get.snackbar(
                              'Course not found', 'No course details available');
                        }
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                s["image"],
                                height: 120,
                                width: 180,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 120,
                                  width: 180,
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(s["title"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(s["institute"],
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              const Text("Top Courses",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              if (topCourses.isEmpty)
                const Text("No top courses available")
              else
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topCourses.length,
                    itemBuilder: (_, i) {
                      final course = topCourses[i];
                      return GestureDetector(
                        onTap: () {
                          final match = courseController.findCourse(
                            id: course["id"]?.toString(),
                            title: course["title"]?.toString(),
                          );
                          if (match != null) {
                            Get.to(() => CourseDisplay(course: match));
                          } else {
                            Get.snackbar('Course not found',
                                'No course details available');
                          }
                        },
                        child: Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  course["image"],
                                  height: 120,
                                  width: 180,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 120,
                                    width: 180,
                                    color: Colors.grey[300],
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(course["title"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(course["institute"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 12, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text('${course["rating"]}',
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 20),
              const Text("Explore Courses",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              Obx(() {
                final items = courseController.filteredCourses;
                if (courseController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (items.isEmpty) {
                  return const Text("No courses available");
                }
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final course = items[i];
                      return GestureDetector(
                        onTap: () => Get.to(() => CourseDisplay(course: course)),
                        child: Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: course.image.startsWith('http')
                                    ? Image.network(
                                        course.image,
                                        height: 120,
                                        width: 180,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        course.image,
                                        height: 120,
                                        width: 180,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(height: 5),
                              Text(course.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14)),
                              Text(course.subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
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
