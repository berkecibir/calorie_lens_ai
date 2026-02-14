import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/headers/age_height_header.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/input_field/age_input_field.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/mixin/age_height_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/sizes/app_sizes.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';
import '../input_field/height_input_field.dart';

class AgeHeightStep extends StatefulWidget {
  final VoidCallback? onNext;
  const AgeHeightStep({super.key, this.onNext});
  @override
  State<AgeHeightStep> createState() => _AgeHeightStepState();
}

class _AgeHeightStepState extends State<AgeHeightStep> with AgeHeightMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: DevicePadding.xlarge.all,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AgeHeightHeader(),
                const SizedBox(height: AppSizes.s48),
                AgeInputField(controller: ageController),
                DeviceSpacing.xlarge.height,
                HeightInputField(controller: heightController),
                const SizedBox(height: AppSizes.s48),
                WizardContinueButton(
                  onPressed: submit,
                  text: AppTexts.continueText,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
