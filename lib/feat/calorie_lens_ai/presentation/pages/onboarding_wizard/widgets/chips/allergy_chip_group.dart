import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';
import 'package:flutter/material.dart';

class AllergyChipGroup extends StatelessWidget {
  final List<String> selectedAllergies;
  final ValueChanged<List<String>> onChanged;
  const AllergyChipGroup({
    super.key,
    required this.selectedAllergies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: OnboardingWizardTexts.commonAllergies.map((allergy) {
        final isSelected = selectedAllergies.contains(allergy);
        return FilterChip(
          label: Text(allergy),
          selected: isSelected,
          onSelected: (selected) {
            final updatedList = List<String>.from(selectedAllergies);
            if (selected) {
              updatedList.add(allergy);
            } else {
              updatedList.remove(allergy);
            }
            onChanged(updatedList);
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
    );
  }
}
