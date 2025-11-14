import '../entities/course_details.dart';
import '../repositories/course_repository.dart';

class GetCourseDetailsUseCase {
  const GetCourseDetailsUseCase(this.repository);

  final CourseRepository repository;

  Future<CourseDetails> call(String courseId) {
    return repository.fetchCourseDetails(courseId);
  }
}
