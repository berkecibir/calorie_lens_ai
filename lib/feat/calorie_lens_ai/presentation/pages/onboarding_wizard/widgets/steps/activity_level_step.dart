import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboardin_wizard_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/activity_level_extension.dart'; // ✅ YENİ IMPORT
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityLevelStep extends StatelessWidget {
  final VoidCallback? onNext;

  const ActivityLevelStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      buildWhen: (previous, current) {
        if (previous is OnboardingWizardLoaded &&
            current is OnboardingWizardLoaded) {
          return previous.userProfile.activityLevel !=
              current.userProfile.activityLevel;
        }
        return previous != current;
      },
      builder: (context, state) {
        ActivityLevel? currentLevel;
        if (state is OnboardingWizardLoaded) {
          currentLevel = state.userProfile.activityLevel;
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                OnboardinWizardTexts.activityLevelStepTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              DeviceSpacing.medium.height,
              Text(
                OnboardinWizardTexts.activityLevelStepDescription,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              DeviceSpacing.xxlarge.height,
              ...ActivityLevel.values.map((level) {
                final isSelected = currentLevel == level;
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.s12),
                  child: _ActivityCard(
                    title: level.title,
                    description: level.description,
                    iconData: level.icon,
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<OnboardingWizardCubit>()
                          .updateActivityLevel(level);
                    },
                  ),
                );
              }),
              DeviceSpacing.xlarge.height,
              ElevatedButton(
                onPressed: currentLevel != null ? onNext : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.circular(AppSizes.s16),
                  ),
                ),
                child: const Text('Devam Et'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.title,
    required this.description,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          color:
              isSelected ? theme.colorScheme.primaryContainer : theme.cardColor,
          borderRadius: AppBorderRadius.circular(AppSizes.s16),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: AppSizes.s1 + 0.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: AppSizes.s4,
                offset: Offset(AppSizes.s0, AppSizes.s2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.s12),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : theme.colorScheme.surfaceContainerHighest
                        .withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: AppSizes.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: AppSizes.s4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.8)
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
