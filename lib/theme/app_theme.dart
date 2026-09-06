import 'package:flutter/material.dart';

class AppTheme {
  static const green = Color(0xFF168C32);
  static const darkGreen = Color(0xFF0E6B27);
  static const lightGreen = Color(0xFFEAF7ED);
  static const paleGreen = Color(0xFFF4FBF5);
  static const orange = Color(0xFFF39A24);
  static const textDark = Color(0xFF1D2A20);
  static const muted = Color(0xFF6B756E);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: green,
        primary: green,
        secondary: orange,
      ),
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8FAF8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0E5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0E5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: green, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
      ),
    );
  }
}
