import 'package:flutter/material.dart';
import '../../features/home/domain/entities/course_summary.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/course/presentation/course_display.dart';

class AppRoutes {
  static const home = '/';
  static const courseDisplay = '/course-display';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case courseDisplay:
        final course = settings.arguments as CourseSummary;
        return MaterialPageRoute(builder: (_) => CourseDisplay(course: course));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Screen not found')),
          ),
        );
    }
  }
}
