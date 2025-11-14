import '../../domain/entities/course_details.dart';

class CourseDetailsModel extends CourseDetails {
  CourseDetailsModel({
    required super.id,
    required super.title,
    required super.institute,
    required super.price,
    required super.currency,
    required super.enrolledStudents,
    required super.rating,
    required super.lectures,
    required super.duration,
    required super.certification,
    required super.thumbnail,
    required super.previewVideo,
    required super.description,
    required super.skills,
    required CourseMetaModel meta,
    required InstructorModel instructor,
    required List<LessonModel> lessons,
    required List<RelatedCourseModel> relatedCourses,
  }) : super(
         meta: meta,
         instructor: instructor,
         lessons: lessons,
         relatedCourses: relatedCourses,
       );

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    final courseJson = Map<String, dynamic>.from(
      (json['course'] as Map?) ?? json,
    );
    return CourseDetailsModel(
      id: (courseJson['id'] ?? '').toString(),
      title: (courseJson['title'] ?? '').toString(),
      institute: (courseJson['institute'] ?? '').toString(),
      price: _toDouble(courseJson['price']),
      currency: (courseJson['currency'] ?? '').toString(),
      enrolledStudents: _toInt(courseJson['enrolledStudents']),
      rating: _toDouble(courseJson['rating']),
      lectures: _toInt(courseJson['lectures']),
      duration: (courseJson['duration'] ?? '').toString(),
      certification: (courseJson['certification'] ?? '').toString(),
      thumbnail: (courseJson['thumbnail'] ?? '').toString(),
      previewVideo: (courseJson['previewVideo'] ?? '').toString(),
      description: (courseJson['description'] ?? '').toString(),
      skills: _mapSkills(courseJson['skills']),
      meta: CourseMetaModel.fromJson(
        Map<String, dynamic>.from(
          (courseJson['courseDetails'] as Map?) ?? <String, dynamic>{},
        ),
      ),
      instructor: InstructorModel.fromJson(
        Map<String, dynamic>.from(
          (courseJson['instructor'] as Map?) ?? <String, dynamic>{},
        ),
      ),
      lessons: LessonModel.fromList(courseJson['lessons']),
      relatedCourses: RelatedCourseModel.fromList(courseJson['relatedCourses']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static List<String> _mapSkills(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return <String>[];
  }
}

class CourseMetaModel extends CourseMeta {
  CourseMetaModel({
    required super.lectures,
    required super.learningTime,
    required super.certification,
  });

  factory CourseMetaModel.fromJson(Map<String, dynamic> json) {
    return CourseMetaModel(
      lectures: (json['lectures'] ?? '').toString(),
      learningTime: (json['learningTime'] ?? '').toString(),
      certification: (json['certification'] ?? '').toString(),
    );
  }
}

class InstructorModel extends Instructor {
  InstructorModel({
    required super.name,
    required super.title,
    required super.bio,
    required super.image,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      name: (json['name'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      bio: (json['bio'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
    );
  }
}

class LessonModel extends Lesson {
  LessonModel({
    required super.id,
    required super.title,
    required super.duration,
    required super.isPreview,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      duration: (json['duration'] ?? '').toString(),
      isPreview: json['isPreview'] == true,
    );
  }

  static List<LessonModel> fromList(dynamic value) {
    if (value is List) {
      return value
          .map((e) => LessonModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return <LessonModel>[];
  }
}

class RelatedCourseModel extends RelatedCourse {
  RelatedCourseModel({
    required super.id,
    required super.title,
    required super.institute,
    required super.price,
    required super.rating,
    required super.image,
  });

  factory RelatedCourseModel.fromJson(Map<String, dynamic> json) {
    return RelatedCourseModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      institute: (json['institute'] ?? '').toString(),
      price: CourseDetailsModel._toDouble(json['price']),
      rating: CourseDetailsModel._toDouble(json['rating']),
      image: (json['image'] ?? '').toString(),
    );
  }

  static List<RelatedCourseModel> fromList(dynamic value) {
    if (value is List) {
      return value
          .map(
            (e) => RelatedCourseModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    }
    return <RelatedCourseModel>[];
  }
}
