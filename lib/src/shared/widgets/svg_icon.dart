import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.icon,
    this.color,
    this.width,
    this.height,
  });

  final String icon;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter: ColorFilter.mode(
        color ?? context.theme.colorScheme.primary,
        BlendMode.srcIn,
      ),
      width: width,
      height: height,
    );
  }
}
