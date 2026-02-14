import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/const/app_texts.dart';

class SignInTitleSection extends StatelessWidget {
  const SignInTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          AppTexts.signInTitleSectionWelcomeAgain,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        DeviceSpacing.small.height,
        Text(
          textAlign: TextAlign.center,
          AppTexts.signInTitleSectionWelcomeAgainSubTitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
