import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';

String? emptyValidator(
  BuildContext context,
  String? s,
) {
  return (s?.trim().isEmpty ?? true)
      ? context.tr.validatorsEmptyFieldsError
      : null;
}

String? dateValidator(
  BuildContext context,
  String? s,
) {
  if (s?.trim().isEmpty ?? true) {
    return context.tr.validatorsEmptyFieldsError;
  }
  if (!isValidDate(s!.trim())) {
    return context.tr.validatorsIncorrectDateError;
  }
  return null;
}

bool isValidDate(String dateString) {
  // First check for the pattern
  if (!RegExp(r'^\d{1,2}.\d{1,2}.\d{4}$').hasMatch(dateString)) {
    return false;
  }

  // Parse the date parts to integers
  final parts = dateString.split('.');
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);

  // Check the ranges of month and year
  if (year < 1000 || year > 3000 || month == 0 || month > 12) {
    return false;
  }

  final monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

// Adjust for leap years
  if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) {
    monthLength[1] = 29;
  }

// Check the range of the day
  return day > 0 && day <= monthLength[month - 1];
}

String? mobileAndEmailValidator(BuildContext context, String? s) {
  final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  if (s?.trim().isEmpty ?? true) {
    return context.tr.validatorsEmptyFieldsError;
  }
  if (emailRegExp.hasMatch(s!.trim()) || isPhoneValid(s)) {
    return null;
  }
  return context.tr.validatorsIncorrectEmailOrPhone;
}
