import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const background = Color(0xFF0A0A14);
  static const card = Color(0xFF111120);
  static const input = Color(0xFF111120);
  static const border = Color(0xFF2A2A4A);

  // Text
  static const foreground = Color(0xFFFFFFFF);
  static const mutedForeground = Color(0xFF9B9BB5);

  // Gradient
  static const gradientStart = Color(0xFF4A90D9);
  static const gradientEnd = Color(0xFF7B2FBE);

  static const gradientPrimary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );
}

class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Inter',
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.gradientStart,
          brightness: Brightness.dark,
        ).copyWith(
          surface: AppColors.background,
          onSurface: AppColors.foreground,
          primary: AppColors.gradientStart,
          secondary: AppColors.gradientEnd,
        ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.input,
      hintStyle: const TextStyle(
        color: AppColors.mutedForeground,
        fontSize: 16,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gradientStart),
      ),
    ),
  );
}
