import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/sizes/app_sizes.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/utils/const/onboardin_wizard_texts.dart';
import '../../../../../../../core/widgets/device_padding/device_padding.dart';

class WeightGoalStep extends StatefulWidget {
  final VoidCallback? onNext;

  const WeightGoalStep({super.key, this.onNext});

  @override
  State<WeightGoalStep> createState() => _WeightGoalStepState();
}

class _WeightGoalStepState extends State<WeightGoalStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _weightController;
  late TextEditingController _goalWeightController;

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

    _weightController = TextEditingController(
      text: initialWeight > 0 ? initialWeight.toString() : '',
    );
    _goalWeightController = TextEditingController(
        text: initialGoalWeight > 0 ? initialGoalWeight.toString() : '');
  }

  @override
  void dispose() {
    _weightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onNext?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: DevicePadding.xlarge.all,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  OnboardingWizardTexts.weightGoalStepTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                DeviceSpacing.medium.height,
                Text(
                  OnboardingWizardTexts.weightGoalStepDescription,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.s48),
                // CURRENT WEIGHT
                TextFormField(
                  controller: _weightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: OnboardingWizardTexts.currentWeight,
                    hintText: OnboardingWizardTexts.exampleWeight,
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
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
                      context
                          .read<OnboardingWizardCubit>()
                          .updateWeight(weight);
                    }
                  },
                ),
                DeviceSpacing.xlarge.height,
                // TARGET WEIGHT
                TextFormField(
                  controller: _goalWeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
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
                      context
                          .read<OnboardingWizardCubit>()
                          .updateTargetWeight(weight);
                    }
                  },
                ),
                const SizedBox(height: AppSizes.s48),
                // Continue Button
                WizardContinueButton(
                  onPressed: _submit,
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
