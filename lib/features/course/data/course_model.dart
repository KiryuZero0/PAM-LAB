class CourseModel {
  final String title;
  final String subtitle;
  final String image;
  final double rating;
  final double price;
  final String description;
  final List<String> skills;
  final int lectures;
  final int weeks;
  final String certificateType;

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.price,
    required this.description,
    required this.skills,
    required this.lectures,
    required this.weeks,
    required this.certificateType,
  });
}
