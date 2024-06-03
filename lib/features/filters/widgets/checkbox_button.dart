import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

class CheckboxButton extends StatelessWidget {
  const CheckboxButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool? value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: context.color.primary,
          activeColor: context.color.tertiary,
          side: BorderSide(color: context.color.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          value: value,
          onChanged: (value) => onChanged(value),
        ),
        Text(
          title,
          style: context.text.rfDewiSemiBold16,
        )
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
