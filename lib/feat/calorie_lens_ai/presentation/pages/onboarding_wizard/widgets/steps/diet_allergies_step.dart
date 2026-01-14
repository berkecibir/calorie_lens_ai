import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/headers/diet_allergies_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/sizes/app_sizes.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';

class DietAllergiesStep extends StatefulWidget {
  final VoidCallback? onNext;

  const DietAllergiesStep({super.key, this.onNext});

  @override
  State<DietAllergiesStep> createState() => _DietAllergiesStepState();
}

class _DietAllergiesStepState extends State<DietAllergiesStep> {
  final List<String> _dietTypes = [
    'Standart / Hepçil',
    'Vejetaryen',
    'Vegan',
    'Pesketaryen',
    'Ketojenik',
    'Paleo',
    'Glutensiz',
  ];

  final List<String> _commonAllergies = [
    'Süt Ürünleri',
    'Yumurta',
    'Gluten',
    'Fıstık',
    'Kuruyemiş',
    'Soya',
    'Balık',
    'Kabuklu Deniz Ürünleri',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
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
              // DIET TYPE SECTION
              Text(
                OnboardingWizardTexts.dietType,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              DeviceSpacing.medium.height,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _dietTypes.map((diet) {
                  final isSelected = currentDiet == diet;
                  return ChoiceChip(
                    label: Text(diet),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        context
                            .read<OnboardingWizardCubit>()
                            .updateDietType(diet);
                      }
                    },
                    selectedColor: theme.colorScheme.primaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              DeviceSpacing.xlarge.height,
              // ALLERGIES SECTION
              Text(
                OnboardingWizardTexts.allergiesAndIntolerance,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              DeviceSpacing.medium.height,

              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _commonAllergies.map((allergy) {
                  final isSelected = currentAllergies.contains(allergy);
                  return FilterChip(
                    label: Text(allergy),
                    selected: isSelected,
                    onSelected: (selected) {
                      final updatedAllergies =
                          List<String>.from(currentAllergies);
                      if (selected) {
                        updatedAllergies.add(allergy);
                      } else {
                        updatedAllergies.remove(allergy);
                      }
                      context
                          .read<OnboardingWizardCubit>()
                          .updateAllergies(updatedAllergies);
                    },
                    selectedColor: theme.colorScheme.tertiaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.onTertiaryContainer
                          : theme.colorScheme.onSurface,
                    ),
                    checkmarkColor: theme.colorScheme.onTertiaryContainer,
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSizes.s48),
              ElevatedButton(
                onPressed: currentDiet != null ? widget.onNext : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
