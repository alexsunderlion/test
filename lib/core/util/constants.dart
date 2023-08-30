import 'package:flutter/material.dart';

class ErrorMessages {
  ErrorMessages._();

  static const connectionError = 'Connection Error';
  static const connectionTimedOut = 'Connection timed out';
  static const fatalErrorMessage = 'We are facing error on our end. Please contact out support team.';
  static const networkError = 'Check your connection and try again';
  static const serverError = 'Oops! Something went wrong';
}

class Thresholds {
  static const pagination = 56;
}

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xFF2050ce);
  static const accentColor = Color(0xFF191176);
  static const textColor = Color(0xFF7E7E7E);
  static const black = Colors.black;
  static const white = Colors.white;
}
