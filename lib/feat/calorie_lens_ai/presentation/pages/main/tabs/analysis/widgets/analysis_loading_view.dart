import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class AnalysisLoadingView extends StatelessWidget {
  const AnalysisLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          DeviceSpacing.large.height,
          Text(
            AnalysisPageTexts.loadingTitle,
            style: theme.textTheme.bodyLarge,
          ),
          DeviceSpacing.small.height,
          Text(
            AnalysisPageTexts.loadingSubtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
