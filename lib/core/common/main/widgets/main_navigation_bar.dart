import 'package:flutter/material.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/extensions/string_extensions.dart';
import '../../../../generated/assets.dart';
import '../../../app/styles/dimensions.dart';
import '../../widgets/svg_icon.dart';

class NavigationBarItemModel {
  const NavigationBarItemModel({
    required this.icon,
    required this.label,
  });

  final String icon;
  final String label;
}

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = [
      NavigationBarItemModel(
        icon: Assets.iconsHome,
        label: 'Главная'.hardcoded,
      ),
      NavigationBarItemModel(
        icon: Assets.iconsNarrativeActive,
        label: 'Избранное'.hardcoded,
      ),
      NavigationBarItemModel(
        icon: Assets.iconsUser,
        label: 'Профиль'.hardcoded,
      ),
    ];
    return BottomAppBar(
      color: context.color.onSecondary,
      padding: EdgeInsets.zero,
      height: 64,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem(
            context: context,
            item: items[0],
            index: 0,
            onPressed: onChanged,
          ),
          _buildTabItem(
            context: context,
            item: items[1],
            index: 1,
            onPressed: onChanged,
          ),
          _buildTabItem(
            context: context,
            item: items[2],
            index: 2,
            onPressed: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required BuildContext context,
    required NavigationBarItemModel item,
    required int index,
    required void Function(int) onPressed,
  }) {
    final color = currentIndex == index
        ? context.color.tertiary
        : context.color.primary.withOpacity(.4);

    return Expanded(
      child: SizedBox(
        height: 100,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.circle),
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  height: 24,
                  width: 24,
                  icon: item.icon,
                  color: color,
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: context.text.rfDewiRegular12.copyWith(
                    color: color,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
