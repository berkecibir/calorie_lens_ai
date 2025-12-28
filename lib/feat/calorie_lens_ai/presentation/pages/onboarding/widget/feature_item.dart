import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final ColorScheme colorScheme;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
    required this.colorScheme,
  });

  factory FeatureItem.nutritionAnalyze({ColorScheme? colorScheme}) {
    return FeatureItem(
      icon: Icons.camera_alt_rounded,
      text: OnboardingTexts.onboardingLastPageFeature1Message,
      colorScheme: colorScheme ?? ColorScheme.fromSeed(seedColor: Colors.green),
    );
  }

  factory FeatureItem.calorieTrack({ColorScheme? colorScheme}) {
    return FeatureItem(
      icon: Icons.track_changes_rounded,
      text: OnboardingTexts.onboardingLastPageFeature2Message,
      colorScheme: colorScheme ?? ColorScheme.fromSeed(seedColor: Colors.green),
    );
  }

  factory FeatureItem.healthAndSafety({ColorScheme? colorScheme}) {
    return FeatureItem(
      icon: Icons.health_and_safety_rounded,
      text: OnboardingTexts.onboardingLastPageFeature3Message,
      colorScheme: colorScheme ?? ColorScheme.fromSeed(seedColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: DevicePadding.small.all,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: AppBorderRadius.circular(AppSizes.s8),
          ),
          child: Icon(
            icon,
            size: AppSizes.s20,
            color: colorScheme.onPrimary,
          ),
        ),
        DeviceSpacing.medium.width,
        Text(
          text,
          style: TextStyle(
            fontSize: AppSizes.s15,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
