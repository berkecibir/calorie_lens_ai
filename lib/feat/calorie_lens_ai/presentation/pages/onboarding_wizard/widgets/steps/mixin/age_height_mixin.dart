import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../age_height_step.dart';

mixin AgeHeightMixin on State<AgeHeightStep> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController ageController;
  late final TextEditingController heightController;

  @override
  void initState() {
    super.initState();
    final cubitState = context.read<OnboardingWizardCubit>().state;

    int initialAge = 0;
    int initialHeight = 0;

    if (cubitState is OnboardingWizardLoaded) {
      initialAge = cubitState.userProfile.age ?? 0;
      initialHeight = cubitState.userProfile.heightCm ?? 0;
    }

    ageController = TextEditingController(
      text: initialAge > 0 ? initialAge.toString() : '',
    );
    heightController = TextEditingController(
      text: initialHeight > 0 ? initialHeight.toString() : '',
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      widget.onNext?.call();
    }
  }
}
