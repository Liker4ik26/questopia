import 'package:flutter/material.dart';
import 'package:questopia/core/app/styles/color_extensions.dart';
import 'package:questopia/core/app/styles/text_extensions.dart';

abstract class AppThemes {
  const AppThemes._();

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: const AppColorScheme.dark().backgroundColor,
    ),
    extensions: <ThemeExtension<dynamic>>[
      _darkColorScheme,
      _textTheme,
    ],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: _darkColorScheme.tertiary.withOpacity(.4),
      selectionHandleColor: _darkColorScheme.tertiary,
    ),
  );

  static const _darkColorScheme = AppColorScheme.dark();
  static final _textTheme = AppTextTheme.base();
}
