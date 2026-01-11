import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/const/onboarding_wizard_texts.dart';

class HeightInputField extends StatelessWidget {
  final TextEditingController controller;
  const HeightInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        labelText: OnboardingWizardTexts.height,
        hintText: OnboardingWizardTexts.exampleHeight,
        prefixIcon: Icon(Icons.height_outlined),
        suffixText: OnboardingWizardTexts.cmSuffix,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return OnboardingWizardTexts.enterYourHeight;
        }
        final height = int.tryParse(value);
        if (height == null || height < 50 || height > 300) {
          return OnboardingWizardTexts.enterAValidHeight;
        }
        return null;
      },
      onChanged: (value) {
        final height = int.tryParse(value);
        if (height != null) {
          context.read<OnboardingWizardCubit>().updateHeight(height);
        }
      },
    );
  }
}
