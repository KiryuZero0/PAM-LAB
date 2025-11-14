import 'package:get/get.dart';

import '../../domain/entities/course_details.dart';
import '../../domain/usecases/get_course_details.dart';

enum CourseDetailsStatus { initial, loading, success, error }

class CourseDetailsController extends GetxController {
  CourseDetailsController({
    required this.courseId,
    required GetCourseDetailsUseCase getCourseDetailsUseCase,
  }) : _getCourseDetailsUseCase = getCourseDetailsUseCase;

  final String courseId;
  final GetCourseDetailsUseCase _getCourseDetailsUseCase;

  final details = Rxn<CourseDetails>();
  final status = CourseDetailsStatus.initial.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      status.value = CourseDetailsStatus.loading;
      errorMessage.value = '';
      details.value = await _getCourseDetailsUseCase(courseId);
      status.value = CourseDetailsStatus.success;
    } catch (error) {
      errorMessage.value = error.toString();
      status.value = CourseDetailsStatus.error;
    }
  }
}
