import 'course_summary.dart';
import 'category.dart';
import 'user_profile.dart';

class Feed {
  const Feed({
    required this.user,
    required this.continueWatching,
    required this.categories,
    required this.suggestions,
    required this.topCourses,
  });

  final UserProfile user;
  final List<CourseSummary> continueWatching;
  final List<Category> categories;
  final List<CourseSummary> suggestions;
  final List<CourseSummary> topCourses;
}
