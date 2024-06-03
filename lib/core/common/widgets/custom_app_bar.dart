import 'package:flutter/material.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.imageUrl,
    this.expandedHeight,
    this.centerTitle = false,
  });

  final String title;
  final String? imageUrl;
  final double? expandedHeight;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      pinned: true,
      expandedHeight: imageUrl != null ? expandedHeight : null,
      title: expandedHeight == null || imageUrl == null ? Text(title) : null,
      centerTitle: centerTitle,
      flexibleSpace: expandedHeight != null && imageUrl != null
          ? FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        background: imageUrl != null
            ? ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                context.color.backgroundColor,
                context.color.backgroundColor
                    .withOpacity(.1),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
            : null,
      )
          : null,
    );
  }
}