import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import '../../app/styles/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
    this.bgColor,
    this.child,
    this.titleColor,
  });

  final String? title;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? titleColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(bgColor ?? context.color.tertiary),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: SmoothBorderRadius(
                  cornerRadius: AppDimensions.tinyMedium, cornerSmoothing: 1),
            ),
          ),
        ),
        child: child ??
            Text(
              title != null ? title! : '',
              style: context.text.rfDewiBold16
                  .copyWith(color: titleColor ?? context.color.primary),
            ).paddingSymmetric(vertical: 4),
      ),
    );
  }
}
