import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFFFF5E1),       // Soft cream background
    primary: Color(0xFFFF6B4A),       // Vibrant coral/tomato accent
    secondary: Color(0xFFFFA726),     // Warm orange
    tertiary: Colors.white,
    inversePrimary: Color(0xFF4A4A4A), // Dark gray for contrast
  ),

  // Text theme configuration
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFF2C3E50), 
      fontSize: 24, 
      fontWeight: FontWeight.bold
    ),
    displayMedium: TextStyle(color: Color(0xFF2C3E50)),
    displaySmall: TextStyle(color: Color(0xFF2C3E50)),
    headlineLarge: TextStyle(color: Color(0xFF2C3E50)),
    headlineMedium: TextStyle(color: Color(0xFF2C3E50)),
    headlineSmall: TextStyle(color: Color(0xFF2C3E50)),
    titleLarge: TextStyle(
      color: Color(0xFFFF6B4A), 
      fontWeight: FontWeight.w600
    ),
    titleMedium: TextStyle(color: Color(0xFF4A4A4A)),
    titleSmall: TextStyle(color: Color(0xFF4A4A4A)),
    bodyLarge: TextStyle(color: Color(0xFF4A4A4A)),
    bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
    bodySmall: TextStyle(color: Colors.grey[600]),
    labelLarge: TextStyle(
      color: Colors.white, 
      fontWeight: FontWeight.bold
    ),
    labelMedium: TextStyle(color: Color(0xFF4A4A4A)),
    labelSmall: TextStyle(color: Color(0xFF4A4A4A)),
  ),

  // Card theme
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    shadowColor: Color(0xFFFF6B4A).withOpacity(0.3),
  ),

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFF5E1),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color(0xFFFF6B4A),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Color(0xFF4A4A4A)),
  ),

  // Icon theme
  iconTheme: IconThemeData(
    color: Color(0xFFFF6B4A),
    size: 24,
  ),

  // TabBar theme
  tabBarTheme: TabBarTheme(
    labelColor: Color(0xFFFF6B4A),
    unselectedLabelColor: Color(0xFF4A4A4A),
    indicatorColor: Color(0xFFFF6B4A),
  ),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFFF6B4A),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),

  scaffoldBackgroundColor: Color(0xFFFFF5E1),
);
