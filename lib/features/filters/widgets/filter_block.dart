import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

class FilterBlock extends StatelessWidget {
  const FilterBlock({super.key, required this.title, required this.widgets});

  final String title;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.text.rfDewiSemiBold20,
        ),
        const SizedBox(height: 16),
        ...widgets,
      ],
    ).paddingSymmetric(horizontal: 24);
  }
}
