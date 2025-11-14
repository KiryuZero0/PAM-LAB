import '../entities/course_details.dart';

abstract class CourseRepository {
  Future<CourseDetails> fetchCourseDetails(String courseId);
}
