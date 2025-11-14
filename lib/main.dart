import 'package:flutter/material.dart';
import 'core/router/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const EduApp());
}

class EduApp extends StatelessWidget {
  const EduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
