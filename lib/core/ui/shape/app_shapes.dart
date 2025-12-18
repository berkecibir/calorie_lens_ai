import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:flutter/material.dart';

abstract class AppShapes {
  static final RoundedRectangleBorder card = RoundedRectangleBorder(
    borderRadius: AppBorderRadius.circular(AppSizes.s12),
  );

  static final RoundedRectangleBorder snackbar = RoundedRectangleBorder(
    borderRadius: AppBorderRadius.circular(AppSizes.s8),
  );

  static final RoundedRectangleBorder button = RoundedRectangleBorder(
    borderRadius: AppBorderRadius.circular(AppSizes.s10),
  );

  static final RoundedRectangleBorder bottomSheet = RoundedRectangleBorder(
    borderRadius: AppBorderRadius.vertical(AppSizes.s16),
  );

  static final RoundedRectangleBorder dialog = RoundedRectangleBorder(
    borderRadius: AppBorderRadius.circular(AppSizes.s14),
  );

  static final OutlineInputBorder input = OutlineInputBorder(
    borderRadius: AppBorderRadius.circular(AppSizes.s10),
    borderSide: BorderSide.none,
  );
}
