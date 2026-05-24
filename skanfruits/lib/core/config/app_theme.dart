import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF7E57C2);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  
  // Status Colors
  static const Color freshColor = Color(0xFF4CAF50);
  static const Color rottenColor = Color(0xFFF44336);
  static const Color confidenceHigh = Color(0xFF4CAF50);
  static const Color confidenceMedium = Color(0xFFFFC107);
  static const Color confidenceLow = Color(0xFFF44336);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
