import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import '../../../core/app/styles/dimensions.dart';


class DetailsButton extends StatelessWidget {
  const DetailsButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.icon,
    this.textStyle,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.small),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: context.color.primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(AppDimensions.small),
              border: Border.all(
                color: context.color.primary.withOpacity(.3),
              ),
            ),
            child: Row(
              children: [
                icon != null
                    ? SvgIcon(
                        height: 16,
                        width: 16,
                        color: context.color.primary,
                        icon: icon!,
                      ).paddingOnly(right: 9)
                    : const SizedBox(),
                Text(
                  text,
                  style: textStyle ?? context.text.rfDewiRegular14,
                ),
              ],
            ),
          ),
        ),
      ),
    ).paddingOnly(right: 6);
  }
}
