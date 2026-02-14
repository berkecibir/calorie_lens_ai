import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';

class SummaryStepHeader extends StatelessWidget {
  const SummaryStepHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          OnboardingWizardTexts.summary,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.medium.height,
        Text(
          OnboardingWizardTexts.checkInfoAndReadyText,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
