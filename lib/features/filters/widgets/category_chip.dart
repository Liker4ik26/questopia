import 'package:flutter/material.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import '../../../core/app/styles/dimensions.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.text,
    this.onSelected,
    required this.selected,
  });

  final String text;
  final bool selected;
  final void Function(bool?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      checkmarkColor: context.color.primary,
      selected: selected,
      selectedColor: context.color.tertiary.withOpacity(.93),
      backgroundColor: context.color.onTertiary.withOpacity(.80),
      showCheckmark: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.circle),
          side: const BorderSide(color: Colors.transparent)),
      label: Text(
        text,
        style: context.text.rfDewiRegular16.copyWith(
          color: context.color.primary,
        ),
      ),
      onSelected: onSelected,
    );
  }
}
