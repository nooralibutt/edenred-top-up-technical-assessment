import 'package:flutter/material.dart';

class AppTheme {
  static const Color whiteColor = Color(0xffffffff);
  static const Color background = Color(0xfff4f4f4);
  static const Color blackColor = Colors.black;
  static const Color lightGreyColor = Color(0xffe6e6e6);
  static const Color purpleAccentColor = Color(0xff506591);
  static const Color transparentColor = Colors.transparent;
  static const Color lightBlack = Color(0xffc3c3c3);
  static Color mediumBlack = Colors.black.withOpacity(0.5);

  static ThemeData buildTheme() {
    final baseData = ThemeData.light();

    return baseData.copyWith(
      scaffoldBackgroundColor: background,
      textTheme: baseData.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: transparentColor,
        foregroundColor: blackColor,
        titleTextStyle: TextStyle(
          color: purpleAccentColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: purpleAccentColor,
            foregroundColor: whiteColor,
            fixedSize: const Size(double.infinity, 50)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: whiteColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: lightGreyColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: lightGreyColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: purpleAccentColor,
            width: 2.0,
          ),
        ),
        hintStyle: const TextStyle(
          color: lightBlack,
        ),
        labelStyle: const TextStyle(
          color: lightBlack,
        ),
      ),
    );
  }
}
