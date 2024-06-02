import 'package:flutter/material.dart';

class ValidatorUtils {
  ValidatorUtils();

  static String? validateEmail(
      {required BuildContext context,
      String? value,
      required String fieldName}) {
    final bool isValidEmail = value != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);

    if (value == null || value.isEmpty || !isValidEmail) {
      return 'Invalid Email';
    }
    return null;
  }

  static String? validatePassword(
      {required BuildContext context,
      String? value,
      required String fieldName,
      int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Weak Password';
    }

    final bool hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final bool hasDigits = RegExp(r'[0-9]').hasMatch(value);
    final bool hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final bool hasSpecialCharacters =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    final bool hasMinLength = value.length >= minLength;

    if (hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength) {
      return null;
    }

    return 'Weak passord';
  }

  static String? validatePasswordMatch(
      {required BuildContext context,
      String? firstPassword,
      String? secondPassword}) {
    final bool arePasswordsEqual = firstPassword != null &&
        secondPassword != null &&
        firstPassword == secondPassword;

    if (firstPassword == null || firstPassword.isEmpty || !arePasswordsEqual) {
      return 'Mismatch Passowrd';
    }
    return null;
  }

  static String? validateEmptyField(
      {required BuildContext context,
      String? name,
      required String fieldName}) {
    if (name == null || name.isEmpty) {
      return 'Invalid field';
    }
    return null;
  }

  static String? validateNameField(
      {required BuildContext context,
      String? name,
      required String fieldName}) {
    if (name == null || name.isEmpty) {
      return 'Invalid field';
    }

    final splitedName = name.trim().split(' ');

    if (splitedName.length < 2) {
      return 'Invalid name';
    }

    return null;
  }
}
