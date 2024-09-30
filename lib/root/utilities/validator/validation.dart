import 'package:flutter/material.dart';

abstract class Validation<T> {
  const Validation();

  String? validate(BuildContext context, T? value);
}

class RequiredValidation<T> extends Validation<T> {
  const RequiredValidation();

  @override
  String? validate(BuildContext context, T? value) {
    if (value == null) {
      return 'This field is required';
    }

    if (value is String && (value as String).isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}

class EmailValidation<T> extends Validation<T> {
  const EmailValidation();

  @override
  String? validate(BuildContext context, T? value) {
    if (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value as String)) {
      return 'Please enter a valid email';
    }
    return null;
  }

}

class PasswordValidation<T> extends Validation<T> {
  const PasswordValidation();

  @override
  String? validate(BuildContext context, T? value) {
    final password = value as String;

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);

    if (!hasLetter || !hasNumber) {
      return 'Password must contain both letters and numbers';
    }

    return null;
  }
}