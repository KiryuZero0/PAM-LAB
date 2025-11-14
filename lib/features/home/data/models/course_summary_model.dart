import '../../domain/entities/course_summary.dart';

class CourseSummaryModel extends CourseSummary {
  CourseSummaryModel({
    required super.id,
    required super.title,
    required super.institute,
    required super.rating,
    required super.image,
    super.progress,
  });

  factory CourseSummaryModel.fromJson(Map<String, dynamic> json) {
    return CourseSummaryModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      institute: (json['institute'] ?? '').toString(),
      rating: _toDouble(json['rating']),
      image: (json['image'] ?? '').toString(),
      progress: _toIntOrNull(json['progress']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _toIntOrNull(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
