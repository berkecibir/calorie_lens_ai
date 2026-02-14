import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';

class GenderHeaderSection extends StatelessWidget {
  const GenderHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          OnboardingWizardTexts.yourGender,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.medium.height,
        Text(
          OnboardingWizardTexts.genderSelectionbodyTitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
