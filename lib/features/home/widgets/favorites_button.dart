import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import '../../../../generated/assets.dart';

class FavoritesButton extends StatelessWidget {
  const FavoritesButton({
    Key? key,
    required this.onPressed,
    required this.isLike,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.circle),
        onTap: onPressed,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: context.color.primary.withOpacity(.12),
              child: isLike
                  ? SvgIcon(
                      height: 24,
                      width: 24,
                      color: context.color.tertiary,
                      icon: Assets.iconsLikeFill,
                    ).paddingAll(10)
                  : SvgIcon(
                      height: 24,
                      width: 24,
                      color: context.color.primary,
                      icon: Assets.iconsLike,
                    ).paddingAll(10),
            ),
          ),
        ),
      ),
    );
  }
}
