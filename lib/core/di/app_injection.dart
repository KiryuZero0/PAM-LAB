import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../network/api_client.dart';
import '../../features/home/data/datasources/feed_remote_data_source.dart';
import '../../features/home/data/repositories/feed_repository_impl.dart';
import '../../features/home/domain/repositories/feed_repository.dart';
import '../../features/home/domain/usecases/get_feed.dart';
import '../../features/course/data/datasources/course_remote_data_source.dart';
import '../../features/course/data/repositories/course_repository_impl.dart';
import '../../features/course/domain/repositories/course_repository.dart';
import '../../features/course/domain/usecases/get_course_details.dart';

class AppInjection {
  static void init() {
    Get.lazyPut<http.Client>(() => http.Client(), fenix: true);
    Get.lazyPut<ApiClient>(
      () => ApiClient(httpClient: Get.find<http.Client>()),
      fenix: true,
    );

    // Home / feed dependencies
    Get.lazyPut<FeedRemoteDataSource>(
      () => FeedRemoteDataSourceImpl(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<FeedRepository>(
      () => FeedRepositoryImpl(Get.find<FeedRemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<GetFeedUseCase>(
      () => GetFeedUseCase(Get.find<FeedRepository>()),
      fenix: true,
    );

    // Course details dependencies
    Get.lazyPut<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<CourseRepository>(
      () => CourseRepositoryImpl(Get.find<CourseRemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<GetCourseDetailsUseCase>(
      () => GetCourseDetailsUseCase(Get.find<CourseRepository>()),
      fenix: true,
    );
  }
}
