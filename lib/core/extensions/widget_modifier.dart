import 'package:flutter/material.dart';

extension WidgetPadding on Widget {
  @Deprecated('Use paddingAll, paddingSymmetric and other instead')
  Widget padding([EdgeInsetsGeometry padding = const EdgeInsets.all(24)]) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}

extension WidgetToSliver on Widget {
  Widget get sliver => SliverToBoxAdapter(child: this);
}
