import 'package:flutter/material.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';

class DietAllergiesHeader extends StatelessWidget {
  const DietAllergiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          OnboardingWizardTexts.dietPreferences,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.medium.height,
        Text(
          OnboardingWizardTexts.dietPreferencesDescription,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
