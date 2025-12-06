import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeHeightStep extends StatefulWidget {
  final VoidCallback? onNext;

  const AgeHeightStep({super.key, this.onNext});

  @override
  State<AgeHeightStep> createState() => _AgeHeightStepState();
}

class _AgeHeightStepState extends State<AgeHeightStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<OnboardingWizardCubit>();
    _ageController =
        TextEditingController(text: cubit.userProfile.age?.toString() ?? '');
    _heightController = TextEditingController(
        text: cubit.userProfile.heightCm?.toString() ?? '');
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
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
    final cubit = context.read<OnboardingWizardCubit>();

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            onChanged: () {
              // Auto-save logic or just wait for submit?
              // Better to update cubit on save or change?
              // Let's update on each valid change to keep state synced?
              // Actually, let's update on changed for smooth feeling, but validate fully on submit.
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Yaş ve Boy',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Metabolizma hızınızı hesaplamak için bu bilgilere ihtiyacımız var.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // AGE INPUT
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Yaş',
                    hintText: 'Örn: 25',
                    prefixIcon: Icon(Icons.cake_outlined),
                    suffixText: 'Yıl',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Lütfen yaşınızı girin';
                    final age = int.tryParse(value);
                    if (age == null || age < 10 || age > 120)
                      return 'Geçerli bir yaş girin';
                    return null;
                  },
                  onChanged: (value) {
                    final age = int.tryParse(value);
                    if (age != null) {
                      cubit.updateUserProfile(
                          cubit.userProfile.copyWith(age: age));
                    }
                  },
                ),
                const SizedBox(height: 24),

                // HEIGHT INPUT
                TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Boy',
                    hintText: 'Örn: 175',
                    prefixIcon: Icon(Icons.height_outlined),
                    suffixText: 'cm',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Lütfen boyunuzu girin';
                    final height = int.tryParse(value);
                    if (height == null || height < 50 || height > 300)
                      return 'Geçerli bir boy girin';
                    return null;
                  },
                  onChanged: (value) {
                    final height = int.tryParse(value);
                    if (height != null) {
                      cubit.updateUserProfile(
                          cubit.userProfile.copyWith(heightCm: height));
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
