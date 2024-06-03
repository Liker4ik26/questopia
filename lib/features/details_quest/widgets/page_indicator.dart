import 'package:flutter/material.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        dotWidth: 6,
        dotHeight: 6,
        expansionFactor: 2.5,
        spacing: 6,
        dotColor: context.color.primary.withOpacity(.51),
        activeDotColor: context.color.primary,
      ),
    );
  }
}
