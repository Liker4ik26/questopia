import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/extensions/context_extensions.dart';


class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({super.key, this.bgColor});

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ClipSmoothRect(
      radius: SmoothBorderRadius(
        cornerRadius: AppDimensions.medium,
        cornerSmoothing: 1,
      ),
      child: Container(
        color: bgColor ?? context.color.onTertiary,
      ),
    );
  }
}
