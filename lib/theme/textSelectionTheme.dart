import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

// Function that returns TextSelectionThemeData
TextSelectionThemeData textSelectionTheme() {
  return TextSelectionThemeData(
    cursorColor: DColors.primary,                  // cursor color
    selectionColor: DColors.primary.withOpacity(0.3), // background when text is selected
    selectionHandleColor: DColors.primary,        // draggable handle color
  );
}
