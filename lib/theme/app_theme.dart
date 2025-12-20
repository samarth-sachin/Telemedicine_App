import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color primaryColor = Color(0xFF2E7C9A);
  static const Color secondaryColor = Color(0xFF6FBFCC);
  static const Color scaffoldBg = Colors.white;

  // Brand gradient (used across app)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primaryColor,
      secondaryColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Global ThemeData
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'K2D',
    scaffoldBackgroundColor: scaffoldBg,

    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),

    // AppBar defaults
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'K2D',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // Text buttons (Skip, etc.)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryColor,
        textStyle: const TextStyle(
          fontFamily: 'K2D',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Elevated buttons (Next, Get Started, etc.)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontFamily: 'K2D',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Bottom navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: Color(0xFF9E9E9E),
      selectedLabelStyle: TextStyle(fontFamily: 'K2D'),
      unselectedLabelStyle: TextStyle(fontFamily: 'K2D'),
      type: BottomNavigationBarType.fixed,
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F7F8),
      hintStyle: const TextStyle(
        fontFamily: 'K2D',
        color: Color(0xFF9E9E9E),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
