import 'package:get/get.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/course_summary.dart';
import '../../domain/entities/feed.dart';
import '../../domain/usecases/get_feed.dart';

enum FeedStatus { initial, loading, success, error }

class FeedController extends GetxController {
  FeedController({required GetFeedUseCase getFeedUseCase})
    : _getFeedUseCase = getFeedUseCase;

  final GetFeedUseCase _getFeedUseCase;

  final status = FeedStatus.initial.obs;
  final errorMessage = ''.obs;
  final selectedCategory = 'All'.obs;

  Feed? _feed;

  Feed? get feed => _feed;

  @override
  void onInit() {
    super.onInit();
    loadFeed();
  }

  Future<void> loadFeed() async {
    try {
      status.value = FeedStatus.loading;
      errorMessage.value = '';
      _feed = await _getFeedUseCase();
      status.value = FeedStatus.success;
    } catch (error) {
      errorMessage.value = error.toString();
      status.value = FeedStatus.error;
    }
  }

  void refreshFeed() => loadFeed();

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  List<Category> get categories => feed?.categories ?? <Category>[];

  List<CourseSummary> get continueWatching =>
      feed?.continueWatching ?? <CourseSummary>[];

  List<CourseSummary> get suggestions => feed?.suggestions ?? <CourseSummary>[];

  List<CourseSummary> get topCourses => feed?.topCourses ?? <CourseSummary>[];

  List<CourseSummary> get exploreCourses {
    final feed = _feed;
    if (feed == null) return <CourseSummary>[];
    final deduplicated = <String, CourseSummary>{
      for (final item in [...feed.topCourses, ...feed.suggestions])
        item.id: item,
    }.values.toList();
    final category = selectedCategory.value;
    if (category == 'All') {
      return deduplicated;
    }
    final query = category.toLowerCase();
    return deduplicated.where((course) {
      return course.title.toLowerCase().contains(query) ||
          course.institute.toLowerCase().contains(query);
    }).toList();
  }
}
