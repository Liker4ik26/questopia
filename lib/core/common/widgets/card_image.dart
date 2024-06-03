import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import 'image_error_widget.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    this.imageUrl,
    this.backgroundColor,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.padding,
    this.errorBackgroundColor,
    this.child,
    this.decoration,
  });

  final String? imageUrl;
  final Color? backgroundColor;
  final Color? errorBackgroundColor;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
      child: imageUrl == null || imageUrl!.isEmpty
          ? ImageErrorWidget(bgColor: errorBackgroundColor ?? backgroundColor)
          : imageUrl!.contains('.svg')
              ? SvgPicture.network(
                  imageUrl!,
                  placeholderBuilder: (context) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: context.color.primary,
                        color: context.color.tertiary,
                      ),
                    );
                  },
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl!,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      padding: padding,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: fit,
                        ),
                      ),
                      child: child,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return ImageErrorWidget(
                      bgColor: errorBackgroundColor ?? backgroundColor,
                    );
                  },
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: context.color.primary,
                        color: context.color.tertiary,
                      ),
                    );
                  },
                ),
    );
  }
}
