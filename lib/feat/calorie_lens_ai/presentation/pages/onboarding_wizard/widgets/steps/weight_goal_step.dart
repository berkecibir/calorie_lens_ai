import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/headers/weight_and_target_header.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/input_field/target_weight_input_field.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/input_field/weight_input_field.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/mixin/weight_goal_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/sizes/app_sizes.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/widgets/device_padding/device_padding.dart';

class WeightGoalStep extends StatefulWidget {
  final VoidCallback? onNext;

  const WeightGoalStep({super.key, this.onNext});

  @override
  State<WeightGoalStep> createState() => _WeightGoalStepState();
}

class _WeightGoalStepState extends State<WeightGoalStep> with WeightGoalMixin {
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
                const WeightAndTargetHeader(),
                const SizedBox(height: AppSizes.s48),
                // CURRENT WEIGHT
                WeightInputField(controller: weightController),
                DeviceSpacing.xlarge.height,
                // TARGET WEIGHT
                TargetWeightInputField(controller: goalWeightController),
                const SizedBox(height: AppSizes.s48),
                // Continue Button
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
