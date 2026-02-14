import 'package:flutter/material.dart';

import '../../sizes/app_sizes.dart';

class AppBorderRadius extends BorderRadius {
  AppBorderRadius.all(double radius) : super.all(Radius.circular(radius));

  // Global border radius class
  AppBorderRadius.only({
    double topLeft = AppSizes.s0,
    double topRight = AppSizes.s0,
    double bottomLeft = AppSizes.s0,
    double bottomRight = AppSizes.s0,
  }) : super.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        );

  // Border radius for horizontal and vertical
  AppBorderRadius.horizontal(double radius)
      : super.horizontal(
          left: Radius.circular(radius),
          right: Radius.circular(radius),
        );

  AppBorderRadius.vertical(double radius)
      : super.vertical(
          top: Radius.circular(radius),
          bottom: Radius.circular(radius),
        );
  // Symmetric border radius
  static AppBorderRadius symmetric({
    double vertical = AppSizes.s0,
    double horizontal = AppSizes.s0,
  }) =>
      AppBorderRadius.only(
        topLeft: horizontal,
        topRight: horizontal,
        bottomLeft: horizontal,
        bottomRight: horizontal,
      );
  // Circular border radius
  static AppBorderRadius circular(double radius) => AppBorderRadius.all(radius);
}
