import 'package:flutter/material.dart';

import 'app_snack_bar.dart';


class DSnackbar {
  DSnackbar._();

  static void showSuccess(BuildContext context, String message,{int seconds=3}) {
    _show(context, message, AppSnackbarType.success,seconds: seconds);
  }

  static void showError(BuildContext context, String message,{int seconds=3}) {
    _show(context, message, AppSnackbarType.error,seconds: seconds);
  }

  static void showInfo(BuildContext context, String message,{int seconds=3}) {
    _show(context, message, AppSnackbarType.info,seconds: seconds);
  }

  static void _show(BuildContext context, String message, AppSnackbarType type,{required int seconds}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppSnackbar(message: message, type: type),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration:  Duration(seconds: seconds),
      ),
    );
  }
}