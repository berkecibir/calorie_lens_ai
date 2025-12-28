import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:flutter/material.dart';

class OnboardingLastPageBodyText extends StatelessWidget {
  const OnboardingLastPageBodyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      OnboardingTexts.onboardingLastPageBodyMessage,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface.withOpacity(0.7),
        height: 1.6,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
      maxLines: 4,
    );
  }
}
