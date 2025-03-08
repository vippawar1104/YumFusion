import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 20, 20, 20),
    primary: const Color.fromARGB(255, 122, 122, 122),
    secondary: const Color.fromARGB(255, 30, 30, 30),
    tertiary: const Color.fromARGB(255, 47, 47, 47),
    inversePrimary: Colors.grey.shade300,
  ),
  
  // Text theme configuration
  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.grey[200]),
    displayMedium: TextStyle(color: Colors.grey[200]),
    displaySmall: TextStyle(color: Colors.grey[300]),
    headlineLarge: TextStyle(color: Colors.grey[200]),
    headlineMedium: TextStyle(color: Colors.grey[300]),
    headlineSmall: TextStyle(color: Colors.grey[300]),
    titleLarge: TextStyle(color: Colors.grey[200]),
    titleMedium: TextStyle(color: Colors.grey[300]),
    titleSmall: TextStyle(color: Colors.grey[400]),
    bodyLarge: TextStyle(color: Colors.grey[300]),
    bodyMedium: TextStyle(color: Colors.grey[400]),
    bodySmall: TextStyle(color: Colors.grey[500]),
    labelLarge: TextStyle(color: Colors.grey[200]),
    labelMedium: TextStyle(color: Colors.grey[300]),
    labelSmall: TextStyle(color: Colors.grey[400]),
  ),

  // Card theme
  cardTheme: CardTheme(
    color: const Color.fromARGB(255, 30, 30, 30),
    elevation: 2,
  ),

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 20, 20, 20),
    titleTextStyle: TextStyle(
      color: Colors.grey[200],
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.grey[300]),
  ),

  // Icon theme
  iconTheme: IconThemeData(
    color: Colors.grey[400],
  ),

  // Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    fillColor: const Color.fromARGB(255, 30, 30, 30),
    filled: true,
    hintStyle: TextStyle(color: Colors.grey[600]),
    labelStyle: TextStyle(color: Colors.grey[400]),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[700]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[700]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400]!),
    ),
  ),

  // TabBar theme
  tabBarTheme: TabBarTheme(
    labelColor: Colors.grey[200],
    unselectedLabelColor: Colors.grey[600],
    indicatorColor: Colors.grey[200],
  ),

  // Bottom navigation bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color.fromARGB(255, 20, 20, 20),
    selectedItemColor: Colors.grey[200],
    unselectedItemColor: Colors.grey[600],
  ),

  // Scaffold background color
  scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),

  // Divider color
  dividerColor: Colors.grey[800],

  // List tile theme
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey[300],
    iconColor: Colors.grey[400],
  ),
);