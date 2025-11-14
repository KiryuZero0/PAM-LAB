import '../../domain/entities/feed.dart';
import 'course_summary_model.dart';
import 'category_model.dart';
import 'user_profile_model.dart';

class FeedModel extends Feed {
  FeedModel({
    required UserProfileModel user,
    required List<CourseSummaryModel> continueWatching,
    required List<CategoryModel> categories,
    required List<CourseSummaryModel> suggestions,
    required List<CourseSummaryModel> topCourses,
  }) : super(
         user: user,
         continueWatching: continueWatching,
         categories: categories,
         suggestions: suggestions,
         topCourses: topCourses,
       );

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      user: UserProfileModel.fromJson(
        Map<String, dynamic>.from(json['user'] ?? <String, dynamic>{}),
      ),
      continueWatching: _mapList(json['continueWatching']),
      categories: _mapCategories(json['categories']),
      suggestions: _mapList(json['suggestions']),
      topCourses: _mapList(json['topCourses']),
    );
  }

  static List<CourseSummaryModel> _mapList(dynamic items) {
    if (items is List) {
      return items
          .map(
            (e) => CourseSummaryModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    }
    return <CourseSummaryModel>[];
  }

  static List<CategoryModel> _mapCategories(dynamic items) {
    if (items is List) {
      return items
          .map(
            (e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
    }
    return <CategoryModel>[];
  }
}
