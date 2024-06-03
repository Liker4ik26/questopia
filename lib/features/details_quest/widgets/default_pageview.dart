import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questopia/features/details_quest/widgets/page_indicator.dart';

class DefaultPageView extends StatelessWidget {
  const DefaultPageView({
    super.key,
    required this.controller,
    required this.items,
  });

  final PageController controller;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: PageView(
            controller: controller,
            children: items,
          ),
        ),
        if (items.length != 1)
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 50,
            child: PageIndicator(
              controller: controller,
              count: items.length,
            ),
          ),
      ],
    );
  }
}
