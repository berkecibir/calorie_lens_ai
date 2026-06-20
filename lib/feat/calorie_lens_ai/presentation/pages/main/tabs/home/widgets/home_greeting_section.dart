import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class HomeGreetingSection extends StatelessWidget {
  final String userName;

  const HomeGreetingSection({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${HomePageTexts.helloPrefix}$userName${HomePageTexts.helloSuffix}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        DeviceSpacing.small.height,
        Text(
          HomePageTexts.nutritionSummarySubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
