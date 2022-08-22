import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
      ),
      canvasColor: AppColors.backgroundLightColor,
      splashColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        color: AppColors.backgroundLightColor,
        titleTextStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 20.0,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      // iconTheme: const IconThemeData(color: AppColors.iconColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      scaffoldBackgroundColor: AppColors.backgroundLightColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundLightColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.cardLightColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.dividerColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.dividerColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.dividerColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primaryColor,
      ),
      splashColor: Colors.transparent,
      canvasColor: AppColors.backgroundDarkColor,
      appBarTheme: const AppBarTheme(
        color: AppColors.backgroundDarkColor,
        titleTextStyle: TextStyle(
          color: AppColors.textLightColor,
          fontSize: 20.0,
        ),
        iconTheme: IconThemeData(color: AppColors.textLightColor),
      ),
      // iconTheme: const IconThemeData(color: AppColors.iconLightColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      scaffoldBackgroundColor: AppColors.backgroundDarkColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundDarkColor,
          selectedItemColor: AppColors.cardLightColor,
          unselectedItemColor: AppColors.backgroundLightColor),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.primaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.dividerColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.dividerColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.dividerColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      ),
    );
  }
}
