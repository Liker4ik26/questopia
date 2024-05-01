import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:questopia/src/app/styles/colors.dart';
import 'package:questopia/src/app/styles/dimensions.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';
import 'package:questopia/src/shared/extensions/widget_modifier.dart';

class CustomTextField extends HookWidget {
  const CustomTextField({
    super.key,
    this.textController,
    required this.textInputAction,
    this.onFieldSubmitted,
    required this.title,
    this.inputFormatters,
    this.validator,
    this.hintStyle,
    this.titleStyle,
    this.textStyle,
    this.textInputType,
    this.autofocus = false,
  });

  final void Function()? onFieldSubmitted;
  final TextInputAction textInputAction;
  final TextEditingController? textController;
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: textController,
          textInputAction: textInputAction,
          autofocus: autofocus,
          textAlignVertical: TextAlignVertical.bottom,
          style: textStyle ?? context.text.rfDewiRegular16,
          decoration: InputDecoration(
            fillColor: context.color.onSecondary,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppDimensions.small,
                cornerSmoothing: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppDimensions.small,
                cornerSmoothing: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppDimensions.small,
                cornerSmoothing: 1,
              ),
            ),
            hintStyle: hintStyle ??
                context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 20,
                  color: context.theme.colorScheme.primary.withOpacity(0.4),
                ),
          ),
          cursorColor: AppColors.leafyGreen,
          validator: validator,
          onFieldSubmitted: (s) {
            onFieldSubmitted?.call();
          },
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
        ),
        Text(
          title,
          style: context.text.rfDewiRegular12.copyWith(
            color: Colors.white.withOpacity(.4),
          ),
        ).paddingOnly(
          left: 12,
          top: 6,
          bottom: 12,
        ),
      ],
    );
  }
}
