import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class DAppTheme {
  DAppTheme._();

  // light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(onPrimary: DColors.primary, ),
  );
}
