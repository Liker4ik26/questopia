import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/typography.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle rubikRegular12;
  final TextStyle rubikMedium24;
  final TextStyle rubikMedium20;
  final TextStyle rubikMedium16;
  final TextStyle rubikMedium12;
  final TextStyle rubikRegular10;
  final TextStyle rubikRegular14;
  final TextStyle rubikMedium14;
  final TextStyle rubikSemiBold20;
  final TextStyle rubikRegular16;
  final TextStyle rubikSemiBold28;

  AppTextTheme._({
    required this.rubikRegular12,
    required this.rubikMedium24,
    required this.rubikMedium20,
    required this.rubikMedium16,
    required this.rubikMedium12,
    required this.rubikRegular10,
    required this.rubikRegular14,
    required this.rubikMedium14,
    required this.rubikSemiBold20,
    required this.rubikRegular16,
    required this.rubikSemiBold28,
  });

  AppTextTheme.base()
      : rubikRegular12 = AppTextStyle.rubikRegular12.value,
        rubikMedium24 = AppTextStyle.rubikMedium24.value,
        rubikMedium20 = AppTextStyle.rubikMedium20.value,
        rubikMedium16 = AppTextStyle.rubikMedium16.value,
        rubikMedium12 = AppTextStyle.rubikMedium12.value,
        rubikRegular10 = AppTextStyle.rubikRegular10.value,
        rubikRegular14 = AppTextStyle.rubikRegular14.value,
        rubikMedium14 = AppTextStyle.rubikMedium14.value,
        rubikSemiBold20 = AppTextStyle.rubikSemiBold20.value,
        rubikRegular16 = AppTextStyle.rubikRegular16.value,
        rubikSemiBold28 = AppTextStyle.rubikSemiBold28.value;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      rubikRegular12: TextStyle.lerp(rubikRegular12, other.rubikRegular12, t)!,
      rubikMedium24: TextStyle.lerp(rubikMedium24, other.rubikMedium24, t)!,
      rubikMedium20: TextStyle.lerp(rubikMedium20, other.rubikMedium20, t)!,
      rubikMedium16: TextStyle.lerp(rubikMedium16, other.rubikMedium16, t)!,
      rubikMedium12: TextStyle.lerp(rubikMedium12, other.rubikMedium12, t)!,
      rubikRegular10: TextStyle.lerp(rubikRegular10, other.rubikRegular10, t)!,
      rubikRegular14: TextStyle.lerp(rubikRegular14, other.rubikRegular14, t)!,
      rubikMedium14: TextStyle.lerp(rubikMedium14, other.rubikMedium14, t)!,
      rubikSemiBold20:
          TextStyle.lerp(rubikSemiBold20, other.rubikSemiBold20, t)!,
      rubikRegular16: TextStyle.lerp(rubikRegular16, other.rubikRegular16, t)!,
      rubikSemiBold28:
          TextStyle.lerp(rubikSemiBold28, other.rubikSemiBold28, t)!,
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
    TextStyle? medium16,
    TextStyle? medium12,
    TextStyle? regular10,
    TextStyle? regular14,
    TextStyle? medium14,
    TextStyle? semiBold20,
    TextStyle? regular16,
    TextStyle? semiBold28,
  }) {
    return AppTextTheme._(
      rubikRegular12: regular12 ?? rubikRegular12,
      rubikMedium24: medium24 ?? rubikMedium24,
      rubikMedium20: regular16 ?? rubikMedium20,
      rubikMedium16: medium16 ?? rubikMedium16,
      rubikMedium12: medium12 ?? rubikMedium12,
      rubikRegular10: regular10 ?? rubikRegular10,
      rubikRegular14: regular14 ?? rubikRegular14,
      rubikMedium14: medium14 ?? rubikMedium14,
      rubikSemiBold20: semiBold20 ?? rubikSemiBold20,
      rubikRegular16: regular16 ?? rubikRegular16,
      rubikSemiBold28: semiBold28 ?? rubikSemiBold28,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppTextTheme не найдена в $context');
