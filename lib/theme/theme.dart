import 'package:flutter/material.dart';
import 'package:money_mate/theme/textSelectionTheme.dart';
import '../utils/constants/colors.dart';
import 'inputDecorationTheme.dart';

class DAppTheme {
  DAppTheme._();

  // 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: DColors.primary,
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: DColors.primary,
      secondary: DColors.secondary,
      onPrimary: DColors.fWhite,
      onSecondary: DColors.fBlack,
      error: DColors.error,
      onPrimaryContainer: Colors.white,

    ),
    fontFamily: 'Poppins',
    inputDecorationTheme: inputDecorationTheme(),
    textSelectionTheme: textSelectionTheme(),
  );


  static ThemeData nightTheme = ThemeData(
    primaryColor: DColors.primary,
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff121212),
    colorScheme: const ColorScheme.dark(
      primary: DColors.primary,
      secondary: DColors.secondary,
      onPrimary: DColors.fWhite,
      onSecondary: DColors.fWhite,
      surface: Color(0xff1E1E1E),
      error: DColors.error,
    ),
    fontFamily: 'Poppins',
    inputDecorationTheme: inputDecorationThemeDark(),
    textSelectionTheme: textSelectionThemeDark(),
  );
}
