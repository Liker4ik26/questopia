import 'package:flutter/material.dart';
import 'package:questopia/core/app/styles/font_families.dart';

enum AppTextStyle {
  rfDewiBold28(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w700,
      fontSize: 28,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiBold20(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w700,
      fontSize: 20,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiBold32(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiRegular12(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiRegular16(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiBold16(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiSemiBold16(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiRegular14(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiSemiBold14(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiSemiBold12(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiSemiBold20(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiRegular24(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w400,
      fontSize: 24,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  rfDewiRegular10(
    TextStyle(
      fontFamily: FontFamilies.rfDewi,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  );

  final TextStyle value;

  const AppTextStyle(this.value);
}
