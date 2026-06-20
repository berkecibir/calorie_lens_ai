import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:flutter/material.dart';

class ReAnalyzeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReAnalyzeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh_rounded),
      label: const Text(AnalysisPageTexts.reAnalyzeButton),
      style: OutlinedButton.styleFrom(
        padding: DevicePadding.medium.onlyVertical,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s16),
        ),
      ),
    );
  }
}
