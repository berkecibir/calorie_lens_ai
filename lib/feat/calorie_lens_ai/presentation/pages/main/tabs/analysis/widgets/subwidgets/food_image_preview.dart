import 'dart:io';
import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:flutter/material.dart';

class FoodImagePreview extends StatelessWidget {
  final File image;

  const FoodImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.circular(AppSizes.s16),
      child: Image.file(
        image,
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }
}
