import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class AnalysisPickerHeader extends StatelessWidget {
  const AnalysisPickerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        DeviceSpacing.xxlarge.height,
        Icon(
          Icons.camera_alt_rounded,
          size: AppSizes.s64,
          color: theme.colorScheme.primary,
        ),
        DeviceSpacing.large.height,
        Text(
          AnalysisPageTexts.pickerTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.small.height,
        Text(
          AnalysisPageTexts.pickerSubtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
