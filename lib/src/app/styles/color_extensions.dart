import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/colors.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  AppColorScheme.light()
      : backgroundColor = Colors.white,
        tertiaryContainer = AppColors.vampireGrey,
        onPrimary = AppColors.whiteSmoke,
        secondary = Colors.white,
        onBackground = AppColors.creole,
        onSecondary = AppColors.dune,
        error = AppColors.deepCoral,
        onTertiary = AppColors.leafyGreen,
        primary = Colors.black,
        tertiary = AppColors.turquoiseBlue;

   AppColorScheme.dark()
      : backgroundColor = AppColors.darkJungleGreen,
        tertiaryContainer = AppColors.vampireGrey,
        onPrimary = AppColors.balticSea,
        secondary = Colors.black,
        onBackground = AppColors.creole,
        onSecondary = AppColors.dune,
        error = AppColors.deepCoral,
        onTertiary = AppColors.leafyGreen,
        tertiary = AppColors.turquoiseBlue,
        primary = Colors.white;

  const AppColorScheme._({
    required this.backgroundColor,
    required this.tertiaryContainer,
    required this.onPrimary,
    required this.secondary,
    required this.onBackground,
    required this.onSecondary,
    required this.error,
    required this.onTertiary,
    required this.primary,
    required this.tertiary,
  });

  // background: AppColors.darkJungleGreen,
  // tertiaryContainer: AppColors.vampireGrey,
  // primary: Colors.black,
  // onPrimary: AppColors.balticSea,
  // secondary: Colors.white,
  // onBackground: AppColors.creole,
  // onSecondary: AppColors.dune,
  // error: AppColors.deepCoral,
  // tertiary: AppColors.turquoiseBlue,
  // onTertiary: AppColors.leafyGreen,
  //

  final Color backgroundColor;
  final Color tertiaryContainer;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onBackground;
  final Color onSecondary;
  final Color error;
  final Color tertiary;
  final Color onTertiary;

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? background,
    Color? tertiaryContainerColor,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? secondaryColor,
    Color? onBackgroundColor,
    Color? onSecondaryColor,
    Color? errorColor,
    Color? tertiaryColor,
    Color? onTertiaryColor,
  }) {
    return AppColorScheme._(
      backgroundColor: background ?? backgroundColor,
      tertiaryContainer: tertiaryContainerColor ?? tertiaryContainer,
      onPrimary: onPrimaryColor ?? onPrimary,
      secondary: secondaryColor ?? secondary,
      onBackground: onBackgroundColor ?? onBackground,
      onSecondary: onSecondaryColor ?? onSecondary,
      error: errorColor ?? error,
      onTertiary: onTertiaryColor ?? onTertiary,
      primary: primaryColor ?? primary,
      tertiary: tertiaryColor ?? tertiary,
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
      tertiaryContainer:
          Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onPrimary: Color.lerp(
        onPrimary,
        other.onPrimary,
        t,
      )!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onSecondary: Color.lerp(
        onSecondary,
        other.onSecondary,
        t,
      )!,
      error: Color.lerp(
        error,
        other.error,
        t,
      )!,
      secondary: Color.lerp(
        secondary,
        other.secondary,
        t,
      )!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      primary: Color.lerp(
        primary,
        other.primary,
        t,
      )!,
      tertiary: Color.lerp(
        tertiary,
        other.tertiary,
        t,
      )!,
    );
  }

  static AppColorScheme of(BuildContext context) =>
      Theme.of(context).extension<AppColorScheme>()!;
}
