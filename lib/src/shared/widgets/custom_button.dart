import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:questopia/src/app/styles/dimensions.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';
import 'package:questopia/src/shared/extensions/widget_modifier.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(context.color.tertiary),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: SmoothBorderRadius(
                  cornerRadius: AppDimensions.tinyMedium, cornerSmoothing: 1),
            ),
          ),
        ),
        child: Text(
          title,
          style: context.text.rfDewiBold16,
        ).paddingSymmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}
