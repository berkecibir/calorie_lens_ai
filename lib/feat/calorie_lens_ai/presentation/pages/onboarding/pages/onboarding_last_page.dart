import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/feature_item.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/onboarding_last_page_body_text.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/widget/onboarding_success_button.dart';
import 'package:flutter/material.dart';

class OnboardingLastPage extends StatelessWidget {
  const OnboardingLastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: DevicePadding.xxlarge.onlyHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon with Animation Effect
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.7),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.3),
                      blurRadius: AppSizes.s32,
                      offset: const Offset(AppSizes.s0, AppSizes.s12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: AppSizes.s100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSizes.s56),
              // Congratulations Badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s20, vertical: AppSizes.s8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  OnboardingTexts.onboardingLastPageCongratsMessage,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DeviceSpacing.xlarge.height,
              // Title
              Text(
                OnboardingTexts.onboardingLastPageTitleMessage,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              DeviceSpacing.large.height,

              // Description
              Padding(
                padding: DevicePadding.medium.onlyHorizontal,
                child: const OnboardingLastPageBodyText(),
              ),
              DeviceSpacing.xlarge.height,
              // Start Button
              OnboardingSuccessButton(),
              DeviceSpacing.xlarge.height,

              // Features List (Optional Enhancement)

              Container(
                padding: DevicePadding.large.all,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: AppBorderRadius.circular(AppSizes.s16),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.2),
                    width: AppSizes.s1,
                  ),
                ),
                child: Column(
                  children: [
                    FeatureItem.nutritionAnalyze(colorScheme: colorScheme),
                    DeviceSpacing.small.height,
                    FeatureItem.calorieTrack(colorScheme: colorScheme),
                    DeviceSpacing.small.height,
                    FeatureItem.healthAndSafety(colorScheme: colorScheme)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
