import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/widgets/steps/weight_goal_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/onboarding_wizard/onboarding_wizard_cubit.dart';

mixin WeightGoalMixin on State<WeightGoalStep> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController weightController;
  late TextEditingController goalWeightController;

  @override
  void initState() {
    super.initState();
    final cubitState = context.read<OnboardingWizardCubit>().state;
    double initialWeight = 0;
    double initialGoalWeight = 0;

    if (cubitState is OnboardingWizardLoaded) {
      initialWeight = cubitState.userProfile.weightKg ?? 0;
      initialGoalWeight = cubitState.userProfile.targetWeightKg ?? 0;
    }

    weightController = TextEditingController(
      text: initialWeight > 0 ? initialWeight.toString() : '',
    );
    goalWeightController = TextEditingController(
        text: initialGoalWeight > 0 ? initialGoalWeight.toString() : '');
  }

  @override
  void dispose() {
    weightController.dispose();
    goalWeightController.dispose();
    super.dispose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      widget.onNext?.call();
    }
  }
}
