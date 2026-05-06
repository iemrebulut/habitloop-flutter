import 'package:flutter/material.dart';

/// Centralized color palette for the application.
///
/// Tokens are grouped by intent (brand, feedback, surfaces) so that switching
/// themes or tweaking the palette only requires touching one file.
class AppColors {
  const AppColors._();

  // Brand
  static const Color primary = Color(0xFF7C3AED);
  static const Color primarySoft = Color(0xFFA78BFA);
  static const Color secondary = Color(0xFF06B6D4);
  static const Color accent = Color(0xFFF472B6);

  // Feedback
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);

  // Light surfaces
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);

  // Dark surfaces
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF334155);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Habit category palette — kept distinct so cards don't blend together.
  static const List<Color> habitPalette = <Color>[
    Color(0xFF7C3AED),
    Color(0xFF06B6D4),
    Color(0xFFF59E0B),
    Color(0xFF22C55E),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
    Color(0xFF3B82F6),
    Color(0xFF14B8A6),
  ];

  /// Brand gradient used on the onboarding hero and progress ring fill.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF7C3AED), Color(0xFF06B6D4)],
  );
}
