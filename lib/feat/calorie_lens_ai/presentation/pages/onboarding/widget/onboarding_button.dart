import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/shape/app_shapes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      height: AppSizes.s56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: AppShapes.largeButton,
            elevation: AppSizes.s2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentPage == totalPages - 1
                  ? OnboardingTexts.startText
                  : OnboardingTexts.continueText,
              style: const TextStyle(
                fontSize: AppSizes.s16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            DeviceSpacing.xsmall.width,
            const Icon(
              Icons.arrow_forward_rounded,
              size: AppSizes.s20,
            ),
          ],
        ),
      ),
    );
  }
}
