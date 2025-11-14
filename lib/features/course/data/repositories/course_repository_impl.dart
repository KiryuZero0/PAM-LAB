import '../../domain/entities/course_details.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_remote_data_source.dart';

class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl(this.remoteDataSource);

  final CourseRemoteDataSource remoteDataSource;

  @override
  Future<CourseDetails> fetchCourseDetails(String courseId) {
    return remoteDataSource.fetchCourseDetails(courseId);
  }
}
