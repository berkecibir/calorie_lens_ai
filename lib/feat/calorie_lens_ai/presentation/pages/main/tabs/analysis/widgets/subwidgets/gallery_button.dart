import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:flutter/material.dart';

class GalleryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GalleryButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.photo_library_rounded),
      label: const Text(AnalysisPageTexts.galleryButton),
      style: OutlinedButton.styleFrom(
        padding: DevicePadding.medium.onlyVertical,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
        ),
      ),
    );
  }
}
