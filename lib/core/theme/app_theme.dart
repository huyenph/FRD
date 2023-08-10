import 'package:flutter/material.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
      ),
      fontFamily: 'lexend',
      canvasColor: AppColors.bgLightColor,
      splashColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        color: AppColors.bgLightColor,
        titleTextStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 16.0,
          fontFamily: 'lexend',
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
          textStyle: const MaterialStatePropertyAll<TextStyle>(
            TextStyle(fontFamily: 'lexend'),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.borderRadiusField),
              side: BorderSide.none,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(AppSize.edgeSpacing),
          ),
        ),
      ),
      scaffoldBackgroundColor: AppColors.bgLightColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgLightColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.cardLightColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.cardLightColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.borderRadiusField,
          )),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.cardLightColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.borderRadiusField,
          )),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.cardLightColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.borderRadiusField,
          )),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.cardLightColor, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.borderRadiusField,
          )),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.borderRadiusField,
          )),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.borderRadiusField,
          )),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primaryColor,
      ),
      fontFamily: 'lexend',
      splashColor: Colors.transparent,
      canvasColor: AppColors.bgDarkColor,
      appBarTheme: const AppBarTheme(
        color: AppColors.bgDarkColor,
        titleTextStyle: TextStyle(
          color: AppColors.textLightColor,
          fontSize: 20.0,
          fontFamily: 'lexend',
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
          textStyle: const MaterialStatePropertyAll<TextStyle>(
            TextStyle(fontFamily: 'lexend'),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      scaffoldBackgroundColor: AppColors.bgDarkColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgDarkColor,
        selectedItemColor: AppColors.cardLightColor,
        unselectedItemColor: AppColors.bgLightColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.primaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      ),
    );
  }
}
