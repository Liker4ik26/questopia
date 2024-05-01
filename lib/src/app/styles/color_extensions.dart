import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/colors.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme.light()
      : backgroundColor = AppColors.onyx,
        onPrimary = AppColors.mikadoYellow,
        secondary = Colors.black,
        tertiary = AppColors.leafyGreen,
        onBackground = AppColors.silverChalice,
        onSecondary = AppColors.darkJungleGreen,
        error = AppColors.deepCoral,
        onTertiary = AppColors.dune,
        primary = Colors.white;

  const AppColorScheme.dark()
      : backgroundColor = AppColors.onyx,
        onPrimary = AppColors.mikadoYellow,
        secondary = Colors.black,
        tertiary = AppColors.leafyGreen,
        onBackground = AppColors.silverChalice,
        onSecondary = AppColors.darkJungleGreen,
        error = AppColors.deepCoral,
        onTertiary = AppColors.dune,
        primary = Colors.white;

  const AppColorScheme._({
    required this.backgroundColor,
    required this.onPrimary,
    required this.secondary,
    required this.tertiary,
    required this.onBackground,
    required this.onSecondary,
    required this.error,
    required this.onTertiary,
    required this.primary,
  });

  final Color backgroundColor;
  final Color onPrimary;
  final Color secondary;
  final Color tertiary;
  final Color onBackground;
  final Color onSecondary;
  final Color error;
  final Color onTertiary;
  final Color primary;

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? background,
    Color? onPrimaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? onBackgroundColor,
    Color? onSecondaryColor,
    Color? errorColor,
    Color? onTertiaryColor,
    Color? primaryColor,
  }) {
    return AppColorScheme._(
      backgroundColor: background ?? backgroundColor,
      onPrimary: onPrimaryColor ?? onPrimary,
      secondary: secondaryColor ?? secondary,
      tertiary: tertiaryColor ?? tertiary,
      onBackground: onBackgroundColor ?? onBackground,
      onSecondary: onSecondaryColor ?? onSecondary,
      error: errorColor ?? error,
      onTertiary: onTertiaryColor ?? onTertiary,
      primary: primaryColor ?? primary,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }

    return AppColorScheme._(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }

  static AppColorScheme of(BuildContext context) =>
      Theme.of(context).extension<AppColorScheme>()!;
}
