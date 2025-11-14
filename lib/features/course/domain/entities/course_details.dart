class CourseDetails {
  const CourseDetails({
    required this.id,
    required this.title,
    required this.institute,
    required this.price,
    required this.currency,
    required this.enrolledStudents,
    required this.rating,
    required this.lectures,
    required this.duration,
    required this.certification,
    required this.thumbnail,
    required this.previewVideo,
    required this.description,
    required this.skills,
    required this.meta,
    required this.instructor,
    required this.lessons,
    required this.relatedCourses,
  });

  final String id;
  final String title;
  final String institute;
  final double price;
  final String currency;
  final int enrolledStudents;
  final double rating;
  final int lectures;
  final String duration;
  final String certification;
  final String thumbnail;
  final String previewVideo;
  final String description;
  final List<String> skills;
  final CourseMeta meta;
  final Instructor instructor;
  final List<Lesson> lessons;
  final List<RelatedCourse> relatedCourses;
}

class CourseMeta {
  const CourseMeta({
    required this.lectures,
    required this.learningTime,
    required this.certification,
  });

  final String lectures;
  final String learningTime;
  final String certification;
}

class Instructor {
  const Instructor({
    required this.name,
    required this.title,
    required this.bio,
    required this.image,
  });

  final String name;
  final String title;
  final String bio;
  final String image;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.isPreview,
  });

  final String id;
  final String title;
  final String duration;
  final bool isPreview;
}

class RelatedCourse {
  const RelatedCourse({
    required this.id,
    required this.title,
    required this.institute,
    required this.price,
    required this.rating,
    required this.image,
  });

  final String id;
  final String title;
  final String institute;
  final double price;
  final double rating;
  final String image;
}
