class CourseSummary {
  const CourseSummary({
    required this.id,
    required this.title,
    required this.institute,
    required this.rating,
    required this.image,
    this.progress,
  });

  final String id;
  final String title;
  final String institute;
  final double rating;
  final String image;
  final int? progress;

  CourseSummary copyWith({
    String? id,
    String? title,
    String? institute,
    double? rating,
    String? image,
    int? progress,
  }) {
    return CourseSummary(
      id: id ?? this.id,
      title: title ?? this.title,
      institute: institute ?? this.institute,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      progress: progress ?? this.progress,
    );
  }
}
