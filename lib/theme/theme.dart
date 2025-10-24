import 'package:flutter/material.dart';
import 'package:money_mate/theme/textSelectionTheme.dart';

import '../utils/constants/colors.dart';
import 'inputDecorationTheme.dart';

class DAppTheme {
  DAppTheme._();

  // light theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: DColors.primary,
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(onPrimary: DColors.primary, ),
    fontFamily: 'Poppins',
    inputDecorationTheme: inputDecorationTheme(),
    textSelectionTheme:textSelectionTheme(),
  );
}
