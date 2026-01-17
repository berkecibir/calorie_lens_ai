import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import '../headers/diet_allergies_header.dart';
import '../chips/diet_type_chip_group.dart';
import '../chips/allergy_chip_group.dart';

class DietAllergiesStep extends StatelessWidget {
  final VoidCallback? onNext;

  const DietAllergiesStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      buildWhen: (previous, current) {
        if (previous is OnboardingWizardLoaded &&
            current is OnboardingWizardLoaded) {
          // Sadece diyet veya alerji listesi değişirse rebuild et
          return previous.userProfile.dietType !=
                  current.userProfile.dietType ||
              !listEquals(previous.userProfile.allergies,
                  current.userProfile.allergies);
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        String? currentDiet;
        List<String> currentAllergies = [];

        if (state is OnboardingWizardLoaded) {
          currentDiet = state.userProfile.dietType;
          currentAllergies = state.userProfile.allergies;
        }

        return SingleChildScrollView(
          padding: DevicePadding.xlarge.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DietAllergiesHeader(),
              DeviceSpacing.xxlarge.height,

              // Diyet Tipi Bölümü
              _buildSectionTitle(theme, OnboardingWizardTexts.dietType),
              DeviceSpacing.medium.height,
              DietTypeChipGroup(
                currentDiet: currentDiet,
                onSelected: (diet) =>
                    context.read<OnboardingWizardCubit>().updateDietType(diet),
              ),

              DeviceSpacing.xlarge.height,

              // Alerji Bölümü
              _buildSectionTitle(
                  theme, OnboardingWizardTexts.allergiesAndIntolerance),
              DeviceSpacing.medium.height,
              AllergyChipGroup(
                selectedAllergies: currentAllergies,
                onChanged: (list) =>
                    context.read<OnboardingWizardCubit>().updateAllergies(list),
              ),

              const SizedBox(height: AppSizes.s48),

              // Devam Et Butonu
              WizardContinueButton(
                onPressed: currentDiet != null ? onNext : null,
                text: AppTexts.continueText,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
