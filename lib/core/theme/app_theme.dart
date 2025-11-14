import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        textTheme: const TextTheme(
          headlineSmall: AppTypography.h1,
          bodyMedium: AppTypography.body,
        ),
        colorScheme: ColorScheme.light(
        surface: Colors.white,
          primary: AppColors.primary,
        ),
      );
}
