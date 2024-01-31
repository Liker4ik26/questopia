import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/font_families.dart';

enum AppTextStyle {
  rubikRegular12(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: -0.33,
    ),
  ),
  rubikMedium24(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w500,
      fontSize: 24,
      letterSpacing: -0.33,
    ),
  ),
  rubikMedium20(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      letterSpacing: -0.33,
    ),
  ),
  rubikMedium16(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: -0.33,
    ),
  ),
  rubikMedium12(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: -0.33,
    ),
  ),
  rubikRegular10(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: -0.33,
    ),
  ),
  rubikRegular14(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: -0.33,
    ),
  ),
  rubikMedium14(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: -0.33,
    ),
  ),
  rubikSemiBold20(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: -0.33,
    ),
  ),
  rubikRegular16(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: -0.33,
    ),
  ),
  rubikSemiBold28(
    TextStyle(
      fontFamily: FontFamilies.rubik,
      fontWeight: FontWeight.w600,
      fontSize: 28,
      letterSpacing: -0.33,
    ),
  );

  final TextStyle value;

  const AppTextStyle(this.value);
}
