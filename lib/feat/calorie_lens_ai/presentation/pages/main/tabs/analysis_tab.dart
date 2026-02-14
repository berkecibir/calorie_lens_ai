import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class AnalysisTab extends StatelessWidget {
  const AnalysisTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_rounded,
            size: AppSizes.s64,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSizes.s16),
          Text(
            'Yemek Analizi',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSizes.s8),
          Text(
            'Yakında burada!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
