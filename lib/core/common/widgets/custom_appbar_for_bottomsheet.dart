import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

class CustomAppbarForBottomSheet extends SliverPersistentHeaderDelegate {
  final String title;

  CustomAppbarForBottomSheet({required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: context.text.rfDewiBold28,
          ),
          const Spacer(),
          IconButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: context.color.onTertiary,
                foregroundColor: context.color.primary),
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
