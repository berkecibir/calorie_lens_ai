import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/row/summary_row.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';
import '../headers/summary_step_header.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<OnboardingWizardCubit, OnboardingWizardState>(
      listener: (context, state) {
        // Loading sırasında burada özel işlem yapılabilir
      },
      builder: (context, state) {
        UserProfileEntity? profile;
        bool isLoading = state is OnboardingWizardLoading;
        if (state is OnboardingWizardLoaded) {
          profile = state.userProfile;
        }
        if (profile == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: DevicePadding.xlarge.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SummaryStepHeader(),
              DeviceSpacing.xxlarge.height,
              _SummaryCard(
                title: OnboardingWizardTexts.personalInfo,
                icon: Icons.person_outline,
                children: [
                  SummaryRow(
                      label: OnboardingWizardTexts.gender,
                      value: profile.gender == Gender.male
                          ? OnboardingWizardTexts.male
                          : OnboardingWizardTexts.female),
                  SummaryRow(
                      label: OnboardingWizardTexts.age,
                      value: '${profile.age} ${OnboardingWizardTexts.year}'),
                  SummaryRow(
                      label: OnboardingWizardTexts.height,
                      value:
                          '${profile.heightCm} ${OnboardingWizardTexts.cmSuffix}'),
                ],
              ),
              DeviceSpacing.medium.height,
              _SummaryCard(
                title: OnboardingWizardTexts.goals,
                icon: Icons.track_changes_outlined,
                children: [
                  SummaryRow(
                      label: OnboardingWizardTexts.currentweightInfoCard,
                      value:
                          '${profile.weightKg} ${OnboardingWizardTexts.kgSuffix}'),
                  SummaryRow(
                      label: OnboardingWizardTexts.targetWeightInfoCard,
                      value:
                          '${profile.targetWeightKg} ${OnboardingWizardTexts.kgSuffix}'),
                  SummaryRow(
                      label: OnboardingWizardTexts.activityInfoCard,
                      value: _getActivityLabel(profile.activityLevel)),
                ],
              ),
              DeviceSpacing.medium.height,
              _SummaryCard(
                title: OnboardingWizardTexts.diet,
                icon: Icons.restaurant_menu,
                children: [
                  SummaryRow(
                      label: OnboardingWizardTexts.dietType,
                      value: profile.dietType ??
                          OnboardingWizardTexts.dietTypeEmptyText),
                  if (profile.allergies.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            OnboardingWizardTexts.allergies,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          DeviceSpacing.small.height,
                          Wrap(
                            spacing: AppSizes.s8,
                            children: profile.allergies
                                .map((a) => Chip(
                                      label: Text(a,
                                          style: const TextStyle(fontSize: 10)),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSizes.s48),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                WizardContinueButton(
                    onPressed: () {
                      context
                          .read<OnboardingWizardCubit>()
                          .finishOnboardingWizard();
                    },
                    text: AppTexts.calculateAndStartText)
            ],
          ),
        );
      },
    );
  }

  String _getActivityLabel(ActivityLevel? level) {
    if (level == null) return '-';
    // Basit bir mapping, dilerseniz ActivityLevelStep'teki map'i public yapıp kullanabilirsiniz.
    switch (level) {
      case ActivityLevel.sedentary:
        return 'Hareketsiz';
      case ActivityLevel.lightlyActive:
        return 'Az Hareketli';
      case ActivityLevel.moderate:
        return 'Orta Hareketli';
      case ActivityLevel.active:
        return 'Çok Hareketli';
      case ActivityLevel.veryActive:
        return 'Aşırı Hareketli';
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SummaryCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: DevicePadding.medium.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}
