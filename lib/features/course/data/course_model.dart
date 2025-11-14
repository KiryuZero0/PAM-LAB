class CourseModel {
  final String? id;
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

  CourseModel({
    this.id,
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

  // ✅ Constructorul care lipsea:
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String?,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      lectures: json['lectures'] ?? 0,
      weeks: json['weeks'] ?? 0,
      certificateType: json['certificateType'] ?? '',
    );
  }

  // (opțional) pentru salvare / debug:
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'rating': rating,
        'price': price,
        'description': description,
        'skills': skills,
        'lectures': lectures,
        'weeks': weeks,
        'certificateType': certificateType,
      };
}
