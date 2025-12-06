import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final cubit = context.read<OnboardingWizardCubit>();

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        final currentDiet = cubit.userProfile.dietType;
        final currentAllergies = cubit.userProfile.allergies;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Beslenme Tercihleri',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Size en uygun beslenme programını hazırlayabilmemiz için tercihlerinizi seçin.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // DIET TYPE SECTION
              Text(
                'Diyet Tipi',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
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
                        cubit.updateUserProfile(
                            cubit.userProfile.copyWith(dietType: diet));
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

              const SizedBox(height: 32),

              // ALLERGIES SECTION
              Text(
                'Alerjiler & Hassasiyetler',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
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
                      cubit.updateUserProfile(
                          cubit.userProfile.copyWith(allergies: updatedAllergies));
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

              const SizedBox(height: 48),
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
