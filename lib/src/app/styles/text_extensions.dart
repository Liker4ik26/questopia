import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/typography.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle rfDewiBold28;
  final TextStyle rfDewiBold20;
  final TextStyle rfDewiBold32;
  final TextStyle rfDewiRegular12;
  final TextStyle rfDewiRegular16;
  final TextStyle rfDewiBold16;
  final TextStyle rfDewiSemiBold16;
  final TextStyle rfDewiRegular14;
  final TextStyle rfDewiSemiBold14;
  final TextStyle rfDewiSemiBold12;
  final TextStyle rfDewiSemiBold20;
  final TextStyle rfDewiRegular24;
  final TextStyle rfDewiRegular10;

  AppTextTheme._({
    required this.rfDewiBold28,
    required this.rfDewiBold20,
    required this.rfDewiBold32,
    required this.rfDewiRegular12,
    required this.rfDewiRegular16,
    required this.rfDewiBold16,
    required this.rfDewiSemiBold16,
    required this.rfDewiRegular14,
    required this.rfDewiSemiBold14,
    required this.rfDewiSemiBold12,
    required this.rfDewiSemiBold20,
    required this.rfDewiRegular24,
    required this.rfDewiRegular10,
  });

  AppTextTheme.base()
      : rfDewiBold28 = AppTextStyle.rfDewiBold28.value,
        rfDewiBold20 = AppTextStyle.rfDewiBold20.value,
        rfDewiBold32 = AppTextStyle.rfDewiBold32.value,
        rfDewiRegular12 = AppTextStyle.rfDewiRegular12.value,
        rfDewiRegular16 = AppTextStyle.rfDewiRegular16.value,
        rfDewiBold16 = AppTextStyle.rfDewiBold16.value,
        rfDewiSemiBold16 = AppTextStyle.rfDewiSemiBold16.value,
        rfDewiRegular14 = AppTextStyle.rfDewiRegular14.value,
        rfDewiSemiBold14 = AppTextStyle.rfDewiSemiBold14.value,
        rfDewiSemiBold12 = AppTextStyle.rfDewiSemiBold12.value,
        rfDewiSemiBold20 = AppTextStyle.rfDewiSemiBold20.value,
        rfDewiRegular24 = AppTextStyle.rfDewiRegular24.value,
        rfDewiRegular10 = AppTextStyle.rfDewiRegular10.value;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      rfDewiBold28: TextStyle.lerp(rfDewiBold28, other.rfDewiBold28, t)!,
      rfDewiBold20: TextStyle.lerp(rfDewiBold20, other.rfDewiBold20, t)!,
      rfDewiBold32: TextStyle.lerp(rfDewiBold32, other.rfDewiBold32, t)!,
      rfDewiRegular12: TextStyle.lerp(rfDewiRegular12, other.rfDewiRegular12, t)!,
      rfDewiRegular16: TextStyle.lerp(rfDewiRegular16, other.rfDewiRegular16, t)!,
      rfDewiBold16: TextStyle.lerp(rfDewiBold16, other.rfDewiBold16, t)!,
      rfDewiSemiBold16: TextStyle.lerp(rfDewiSemiBold16, other.rfDewiSemiBold16, t)!,
      rfDewiRegular14: TextStyle.lerp(rfDewiRegular14, other.rfDewiRegular14, t)!,
      rfDewiSemiBold14:
          TextStyle.lerp(rfDewiSemiBold14, other.rfDewiSemiBold14, t)!,
      rfDewiSemiBold12: TextStyle.lerp(rfDewiSemiBold12, other.rfDewiRegular16, t)!,
      rfDewiSemiBold20: TextStyle.lerp(rfDewiSemiBold20, other.rfDewiSemiBold20, t)!,
      rfDewiRegular24: TextStyle.lerp(rfDewiRegular24, other.rfDewiRegular24, t)!,
      rfDewiRegular10: TextStyle.lerp(rfDewiRegular10, other.rfDewiRegular10, t)!,
    );
  }

  static AppTextTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextTheme>() ??
        _throwThemeExceptionFromFunc(context);
  }

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? regular12,
    TextStyle? medium24,
    TextStyle? medium20,
    TextStyle? bold32,
    TextStyle? medium16,
    TextStyle? medium12,
    TextStyle? regular10,
    TextStyle? regular14,
    TextStyle? medium14,
    TextStyle? semiBold20,
    TextStyle? semiBold12,
    TextStyle? semiBold28,
    TextStyle? regular24,
  }) {
    return AppTextTheme._(
      rfDewiBold28: regular12 ?? rfDewiBold28,
      rfDewiBold20: medium24 ?? rfDewiBold20,
      rfDewiBold32: bold32 ?? rfDewiBold32,
      rfDewiRegular12: medium16 ?? rfDewiRegular12,
      rfDewiRegular16: medium12 ?? rfDewiRegular16,
      rfDewiBold16: regular10 ?? rfDewiBold16,
      rfDewiSemiBold16: regular14 ?? rfDewiSemiBold16,
      rfDewiRegular14: medium14 ?? rfDewiRegular14,
      rfDewiSemiBold14: semiBold20 ?? rfDewiSemiBold14,
      rfDewiSemiBold12: semiBold12 ?? rfDewiSemiBold12,
      rfDewiSemiBold20: semiBold28 ?? rfDewiSemiBold20,
      rfDewiRegular24: semiBold28 ?? rfDewiRegular24,
      rfDewiRegular10: regular10 ?? rfDewiRegular10,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppTextTheme не найдена в $context');
