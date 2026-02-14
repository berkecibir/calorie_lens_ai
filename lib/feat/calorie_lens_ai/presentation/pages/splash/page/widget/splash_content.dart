import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  final ColorScheme colorScheme;
  final ThemeData theme;

  const SplashContent({
    super.key,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App Logo
        Icon(
          Icons.restaurant_menu,
          size: AppSizes.s100,
          color: colorScheme.primary,
        ),
        DeviceSpacing.xlarge.height,
        // App Name
        Text(
          AppTexts.appName,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.s48),

        // Loading Indicator
        CircularProgressIndicator.adaptive(
          backgroundColor: colorScheme.surface,
        ),
      ],
    );
  }
}
