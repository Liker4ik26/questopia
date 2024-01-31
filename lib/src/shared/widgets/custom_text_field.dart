
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';

class CustomTextField extends HookWidget {
  const CustomTextField({
    super.key,
    this.textController,
    required this.textInputAction,
    this.onFieldSubmitted,
    required this.hintText,
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
  final String hintText;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? context.theme.textTheme.headlineSmall?.copyWith(
            color: context.theme.colorScheme.primary.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 2),
        TextFormField(
          controller: textController,
          textInputAction: textInputAction,
          autofocus: autofocus,
          style: textStyle ?? context.theme.textTheme.headlineLarge?.copyWith(fontSize: 20),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: hintText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary.withOpacity(.4),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary.withOpacity(.4),
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary.withOpacity(.4),
              ),
            ),
            hintStyle: hintStyle ?? context.theme.textTheme.headlineLarge?.copyWith(
              fontSize: 20,
              color: context.theme.colorScheme.primary.withOpacity(0.4),
            ),
          ),
          validator: validator,
          onFieldSubmitted: (s) {
            onFieldSubmitted?.call();
          },
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
        ),
      ],
    );
  }
}
