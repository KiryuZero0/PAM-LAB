import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../course/data/course_model.dart';

class CourseController extends GetxController {
  final courses = <CourseModel>[].obs;
  final isLoading = false.obs;
  final selectedCategory = 'All'.obs;
  final Map<String, CourseModel> _coursesById = {};

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      isLoading.value = true;
      final String response =
          await rootBundle.loadString('assets/data/courses.json');
      final List<dynamic> data = json.decode(response);
      final loadedCourses =
          data.map((e) => CourseModel.fromJson(e)).toList(growable: false);
      courses.value = loadedCourses;
      _coursesById
        ..clear()
        ..addEntries(loadedCourses.where((c) => c.id != null).map(
            (course) => MapEntry(course.id!, course)));
    } catch (e, st) {
      developer.log('Error loading courses',
          name: 'CourseController', error: e, stackTrace: st);
    } finally {
      isLoading.value = false;
    }
  }

  List<CourseModel> get filteredCourses {
    final cat = selectedCategory.value;
    if (cat == 'All') return courses;
    final lower = cat.toLowerCase();
    return courses.where((c) {
      final inSkills = c.skills.any((s) => s.toLowerCase().contains(lower));
      final inTitle = c.title.toLowerCase().contains(lower);
      final inSubtitle = c.subtitle.toLowerCase().contains(lower);
      return inSkills || inTitle || inSubtitle;
    }).toList();
  }

  void onCategorySelected(String category) {
    selectedCategory.value = category;
  }

  CourseModel? findCourse({String? id, String? title}) {
    if (id != null && id.isNotEmpty) {
      final match = _coursesById[id];
      if (match != null) {
        return match;
      }
    }
    if (title != null && title.isNotEmpty) {
      for (final course in courses) {
        if (course.title == title) {
          return course;
        }
      }
    }
    return null;
  }
}
