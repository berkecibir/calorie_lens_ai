import 'package:calorie_lens_ai_app/core/utils/const/app_regex.dart';
import 'package:calorie_lens_ai_app/core/utils/const/onboarding_wizard_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/validators/body_validator.dart';
import '../../../../cubits/onboarding_wizard/onboarding_wizard_cubit.dart';

class WeightInputField extends StatelessWidget {
  final TextEditingController controller;
  const WeightInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(AppRegex.decimalWeightPattern))
      ],
      decoration: const InputDecoration(
        labelText: OnboardingWizardTexts.exampleWeight,
        prefixIcon: Icon(Icons.monitor_weight_outlined),
        suffixText: OnboardingWizardTexts.kgSuffix,
      ),
      validator: BodyValidator.validateWeight,
      onChanged: (value) {
        final weight = double.tryParse(value);
        if (weight != null) {
          context.read<OnboardingWizardCubit>().updateWeight(weight);
        }
      },
    );
  }
}
