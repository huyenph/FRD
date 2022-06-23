import 'package:flutter/material.dart';

class AppTheme {
  static const Color appColor = Colors.deepPurpleAccent;

  static ThemeData get light {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: appColor,
      ),
      appBarTheme: const AppBarTheme(color: appColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(appColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(appColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: appColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(appColor),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: appColor,
      ),
      appBarTheme: const AppBarTheme(color: appColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(appColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF263238),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF263238),
        selectedItemColor: appColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(appColor),
      ),
    );
  }
}
