import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/activity_level_extension.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/row/summary_row.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/sections/allergies_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/cards/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';
import '../headers/summary_step_header.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingWizardCubit, OnboardingWizardState>(
      // Sadece state tipi değiştiğinde rebuild et
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        // Loading sırasında özel işlem yapılabilir
      },
      builder: (context, state) {
        final isLoading = state is OnboardingWizardLoading;

        if (state is! OnboardingWizardLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = state.userProfile;

        return SingleChildScrollView(
          padding: DevicePadding.xlarge.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SummaryStepHeader(),
              DeviceSpacing.xxlarge.height,
              // Personal Info Card
              _buildPersonalInfoCard(profile),
              DeviceSpacing.medium.height,
              // Goals Card
              _buildGoalsCard(profile),
              DeviceSpacing.medium.height,
              // Diet Card
              _buildDietCard(profile),
              const SizedBox(height: AppSizes.s48),
              // Submit Button
              _buildSubmitButton(context, isLoading),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPersonalInfoCard(UserProfileEntity profile) {
    return SummaryCard(
      title: OnboardingWizardTexts.personalInfo,
      icon: Icons.person_outline,
      children: [
        SummaryRow(
          label: OnboardingWizardTexts.gender,
          value: profile.gender == Gender.male
              ? OnboardingWizardTexts.male
              : OnboardingWizardTexts.female,
        ),
        SummaryRow(
          label: OnboardingWizardTexts.age,
          value: '${profile.age} ${OnboardingWizardTexts.year}',
        ),
        SummaryRow(
          label: OnboardingWizardTexts.height,
          value: '${profile.heightCm} ${OnboardingWizardTexts.cmSuffix}',
        ),
      ],
    );
  }

  Widget _buildGoalsCard(UserProfileEntity profile) {
    return SummaryCard(
      title: OnboardingWizardTexts.goals,
      icon: Icons.track_changes_outlined,
      children: [
        SummaryRow(
          label: OnboardingWizardTexts.currentweightInfoCard,
          value: '${profile.weightKg} ${OnboardingWizardTexts.kgSuffix}',
        ),
        SummaryRow(
          label: OnboardingWizardTexts.targetWeightInfoCard,
          value: '${profile.targetWeightKg} ${OnboardingWizardTexts.kgSuffix}',
        ),
        SummaryRow(
          label: OnboardingWizardTexts.activityInfoCard,
          value: profile.activityLevel?.title ?? '-',
        ),
      ],
    );
  }

  Widget _buildDietCard(UserProfileEntity profile) {
    return SummaryCard(
      title: OnboardingWizardTexts.diet,
      icon: Icons.restaurant_menu,
      children: [
        SummaryRow(
          label: OnboardingWizardTexts.dietType,
          value: profile.dietType ?? OnboardingWizardTexts.dietTypeEmptyText,
        ),
        AllergiesSection(allergies: profile.allergies),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool isLoading) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return WizardContinueButton(
      onPressed: () {
        context.read<OnboardingWizardCubit>().finishOnboardingWizard();
      },
      text: AppTexts.calculateAndStartText,
    );
  }
}
