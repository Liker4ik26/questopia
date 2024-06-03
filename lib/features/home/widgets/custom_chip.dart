import 'package:flutter/material.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import '../../../core/app/styles/dimensions.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    this.onSelected,
    required this.selected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      selectedColor: context.color.tertiary,
      backgroundColor: context.color.onTertiary,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.small),
        side: const BorderSide(color: Colors.transparent)
      ),
      label: Text(
        text,
        style: context.text.rfDewiRegular16.copyWith(
          color: selected
              ? context.color.primary
              : context.color.primary.withOpacity(.4),
        ),
      ),
      onSelected: onSelected,
    );
  }
}
