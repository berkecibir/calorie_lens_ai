import 'package:flutter/material.dart';

import '../../../../../../../core/utils/const/onboardin_wizard_texts.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';

class AgeHeightHeader extends StatelessWidget {
  const AgeHeightHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          OnboardingWizardTexts.ageAndHeightTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.medium.height,
        Text(
          OnboardingWizardTexts.ageAndHeightDescription,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
