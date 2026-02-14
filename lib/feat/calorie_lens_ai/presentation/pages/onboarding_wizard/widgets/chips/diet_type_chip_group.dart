import 'package:flutter/material.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';

class DietTypeChipGroup extends StatelessWidget {
  final String? currentDiet;
  final ValueChanged<String> onSelected;
  const DietTypeChipGroup(
      {super.key, this.currentDiet, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: OnboardingWizardTexts.dietTypes.map((diet) {
        final isSelected = currentDiet == diet;
        return ChoiceChip(
          label: Text(diet),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) onSelected(diet);
          },
          selectedColor: theme.colorScheme.primaryContainer,
          labelStyle: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
}
