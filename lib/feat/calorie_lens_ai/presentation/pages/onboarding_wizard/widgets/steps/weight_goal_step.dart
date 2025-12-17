import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    //final cubit = context.read<OnboardingWizardCubit>();

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Kilo ve Hedef',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Mevcut kilonuz ve ulaşmak istediğiniz hedef kilo.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

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
                    labelText: 'Mevcut Kilo',
                    hintText: 'Örn: 70.5',
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                    suffixText: 'kg',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Kilonuzu girin';
                    final weight = double.tryParse(value);
                    if (weight == null || weight < 30 || weight > 300) {
                      return 'Geçerli bir kilo girin';
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
                const SizedBox(height: 24),

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
                    labelText: 'Hedef Kilo',
                    hintText: 'Örn: 65.0',
                    prefixIcon: Icon(Icons.flag_outlined),
                    suffixText: 'kg',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hedef kiloyu girin';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight < 30 || weight > 300) {
                      return 'Geçerli bir kilo girin';
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

                const SizedBox(height: 48),

                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Devam Et'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
