import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/color_extensions.dart';
import 'package:questopia/src/app/styles/text_extensions.dart';

abstract class AppThemes {
  const AppThemes._();

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: AppColorScheme.light().backgroundColor,
    ),
    extensions: <ThemeExtension<dynamic>>[
      _lightColorScheme,
      _darkColorScheme,
      _textTheme,
    ],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );

  static final _lightColorScheme = AppColorScheme.light();
  static final _darkColorScheme = AppColorScheme.dark();
  static final _textTheme = AppTextTheme.base();
}
