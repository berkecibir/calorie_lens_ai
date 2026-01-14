import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/cards/gender_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionRow extends StatelessWidget {
  final Gender? currentGender;

  const GenderSelectionRow({super.key, required this.currentGender});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GenderCard(
            icon: Icons.male,
            label: OnboardingWizardTexts.male,
            isSelected: currentGender == Gender.male,
            onTap: () =>
                context.read<OnboardingWizardCubit>().updateGender(Gender.male),
          ),
        ),
        DeviceSpacing.xlarge.width,
        Expanded(
          child: GenderCard(
            icon: Icons.female,
            label: OnboardingWizardTexts.female,
            isSelected: currentGender == Gender.female,
            onTap: () => context
                .read<OnboardingWizardCubit>()
                .updateGender(Gender.female),
          ),
        ),
      ],
    );
  }
}
