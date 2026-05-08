import 'package:flutter/material.dart';

class BottomNavBarColors {
  // Primary Gradient Colors
  static const Color primaryStart = Color(0xFF6366F1); // Indigo
  static const Color primaryEnd = Color(0xFFA855F7); // Purple

  // Background Colors
  static const Color glassBackground = Color.fromARGB(0, 255, 255, 255);
  static const Color darkGlassBackground = Color.fromARGB(0, 0, 0, 0);

  // Accent Colors
  static const Color electricBlue = Color(0xFF3B82F6);
  static const Color neonPink = Color(0xFFEC4899);

  // Text & Icons
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [primaryStart, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
