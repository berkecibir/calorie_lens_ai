import 'package:calorie_lens_ai_app/core/utils/const/app_regex.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';

class TargetWeightInputField extends StatelessWidget {
  final TextEditingController controller;
  const TargetWeightInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(AppRegex.decimalWeightPattern)),
      ],
      decoration: const InputDecoration(
        labelText: OnboardingWizardTexts.targetWeight,
        hintText: OnboardingWizardTexts.exampleWeight2,
        prefixIcon: Icon(Icons.flag_outlined),
        suffixText: OnboardingWizardTexts.kgSuffix,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return OnboardingWizardTexts.enterYourWeight;
        }
        final weight = double.tryParse(value);
        if (weight == null || weight < 30 || weight > 300) {
          return OnboardingWizardTexts.enterAValidWeight;
        }
        return null;
      },
      onChanged: (value) {
        final weight = double.tryParse(value);
        if (weight != null) {
          context.read<OnboardingWizardCubit>().updateTargetWeight(weight);
        }
      },
    );
  }
}
