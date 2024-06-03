import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/styles/colors.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.suffixIcon,
    this.enabled,
    this.bgColor,
    super.key,
    this.hint,
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
    this.isPassword = false,
    this.onChanged,
    this.prefixText,
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
  final Widget? suffixIcon;
  final Color? bgColor;
  final String? hint;
  final bool? enabled;
  final bool? isPassword;
  final String? prefixText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: textController,
          textInputAction: textInputAction,
          autofocus: autofocus,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.bottom,
          style: textStyle ?? context.text.rfDewiRegular16,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixText: prefixText,
            prefixStyle: context.text.rfDewiRegular16,
            hintText: hint,
            suffixIcon: suffixIcon,
            fillColor: bgColor ?? context.color.onSecondary,
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
                context.text.rfDewiRegular16.copyWith(
                  color: context.color.primary.withOpacity(0.4),
                ),
          ),
          obscureText: isPassword ?? false,
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
          bottom: 6,
        ),
      ],
    );
  }
}
