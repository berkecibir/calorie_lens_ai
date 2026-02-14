import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';
import '../../../../../../../core/utils/validators/body_validator.dart';

class AgeInputField extends StatelessWidget {
  final TextEditingController controller;

  const AgeInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        labelText: OnboardingWizardTexts.age,
        hintText: OnboardingWizardTexts.exampleAge,
        prefixIcon: Icon(Icons.cake_outlined),
        suffixText: OnboardingWizardTexts.year,
      ),
      validator: BodyValidator.validateAge,
      onChanged: (value) {
        final age = int.tryParse(value);
        if (age != null) {
          context.read<OnboardingWizardCubit>().updateAge(age);
        }
      },
    );
  }
}
