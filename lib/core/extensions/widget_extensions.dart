import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget paddingLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left,
        top,
        right,
        bottom,
      ),
      child: this,
    );
  }

  Widget safeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) {
    return SafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  Widget get sliverToBox {
    return SliverToBoxAdapter(
      child: this,
    );
  }

  Widget sliverPaddingAll(double padding) {
    return SliverPadding(
      padding: EdgeInsets.all(padding),
      sliver: this,
    );
  }

  Widget sliverPaddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      sliver: this,
    );
  }

  Widget sliverPaddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      sliver: this,
    );
  }

  Widget sliverPaddingLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        left,
        top,
        right,
        bottom,
      ),
      sliver: this,
    );
  }

  Widget sliverSafeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) {
    return SliverSafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      sliver: this,
    );
  }
}
