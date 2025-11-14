import '../../course/data/course_model.dart';

final mockCourses = <CourseModel>[
  CourseModel(
    title: 'Web Design Fundamentals',
    subtitle: 'Web Development University',
    image: 'assets/images/WEB.png',
    rating: 4.9,
    price: 35,
    description:
        'Learn the core principles of modern web design — layouts, typography, and responsive structure using Figma and Flutter UI kits.',
    skills: ['Responsive Layout', 'UI Principles', 'Typography', 'Wireframing'],
    lectures: 45,
    weeks: 4,
    certificateType: 'Online Certificate',
  ),
  CourseModel(
    title: 'Branding & Identity Design',
    subtitle: 'Innovation & Design School',
    image: 'assets/images/BRAND.png',
    rating: 4.4,
    price: 29,
    description:
        'Master the art of creating brand identities. Learn logo creation, color psychology, and brand consistency techniques.',
    skills: ['Logo Design', 'Color Theory', 'Brand Strategy'],
    lectures: 38,
    weeks: 3,
    certificateType: 'Professional Certificate',
  ),
  CourseModel(
    title: 'Typography & Layout Design',
    subtitle: 'Visual Communication College',
    image: 'assets/images/TYPO.png',
    rating: 4.7,
    price: 32,
    description:
        'A creative exploration of typography and layout composition. Create balanced, engaging visual designs across digital and print formats.',
    skills: ['Typography', 'Composition', 'Editorial Design'],
    lectures: 50,
    weeks: 4,
    certificateType: 'Digital Certificate',
  ),
];

