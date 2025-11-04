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
      borderSide: BorderSide(color: DColors.grey.withOpacity(0.5)),
    ),
  );
}


InputDecorationTheme inputDecorationThemeDark() {
  return InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: DColors.primary),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintStyle: TextStyle(color: DColors.fWhite.withOpacity(0.6)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: DColors.fWhite.withOpacity(0.2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: DColors.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: DColors.fWhite.withOpacity(0.2)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: DColors.grey),
    ),
  );
}
