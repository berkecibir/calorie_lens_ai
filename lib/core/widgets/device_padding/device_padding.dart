import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

final class PaddingType {
  PaddingType._();
}

///Project's global padding class
enum DevicePadding {
  ///This value is 5
  xsmall(AppSizes.s5),

  ///This value is 10
  small(AppSizes.s10),

  ///This value is 15
  medium(AppSizes.s15),

  ///This value is 20
  large(AppSizes.s20),

  ///This value is 25
  xlarge(AppSizes.s25),

  ///This value is 30
  xxlarge(AppSizes.s30);

  final double value;

  const DevicePadding(this.value);

  EdgeInsets get all => EdgeInsets.all(value);

  EdgeInsets get onlyBottom => EdgeInsets.only(bottom: value);

  EdgeInsets get onlyRight => EdgeInsets.only(right: value);

  EdgeInsets get onlyHorizontal => EdgeInsets.symmetric(horizontal: value);

  EdgeInsets get onlyVertical => EdgeInsets.symmetric(vertical: value);

  EdgeInsets get allSymtetric =>
      EdgeInsets.symmetric(horizontal: value, vertical: value);
}
