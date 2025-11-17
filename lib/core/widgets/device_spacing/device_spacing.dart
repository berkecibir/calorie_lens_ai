import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

final class SpacingType {
  SpacingType._();
}

/// Project's global spacing class
enum DeviceSpacing {
  /// This value 5
  xsmall(AppSizes.s5),

  /// This value 10
  small(AppSizes.s10),

  ///  This value 15
  medium(AppSizes.s15),

  /// This value 20
  large(AppSizes.s20),

  /// This value 30
  xlarge(AppSizes.s30);

  final double value;
  const DeviceSpacing(this.value);

  ///  SizedBox for only width
  SizedBox get width => SizedBox(width: value);

  ///  SizedBox for only height
  SizedBox get height => SizedBox(height: value);

  /// SizedBox for height and width
  SizedBox get square => SizedBox(width: value, height: value);
}
