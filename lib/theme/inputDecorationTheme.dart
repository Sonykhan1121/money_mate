import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    // filled: true,
    floatingLabelStyle: TextStyle(color: DColors.primary),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintStyle: TextStyle(color: DColors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: DColors.primary),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: DColors.error),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: DColors.grey),
    ),
  );
}
