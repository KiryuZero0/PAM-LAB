import '../../../../core/network/api_client.dart';
import '../models/course_details_model.dart';

abstract class CourseRemoteDataSource {
  Future<CourseDetailsModel> fetchCourseDetails(String courseId);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  CourseRemoteDataSourceImpl(this.client);

  final ApiClient client;

  @override
  Future<CourseDetailsModel> fetchCourseDetails(String courseId) async {
    // Current API exposes a single details endpoint that isn't id-specific,
    // but keeping the argument allows easy refactors once the API evolves.
    final response = await client.getJson('/v1/feed/details');
    return CourseDetailsModel.fromJson(response);
  }
}
