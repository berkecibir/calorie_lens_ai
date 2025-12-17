import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
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
    final cubitState = context.read<OnboardingWizardCubit>().state;

    int initialAge = 0;
    int initialHeight = 0;

    if (cubitState is OnboardingWizardLoaded) {
      initialAge = cubitState.userProfile.age ?? 0;
      initialHeight = cubitState.userProfile.heightCm ?? 0;
    }

    _ageController = TextEditingController(
      text: initialAge > 0 ? initialAge.toString() : '',
    );
    _heightController = TextEditingController(
      text: initialHeight > 0 ? initialHeight.toString() : '',
    );
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
                  'Yaş ve Boy',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                DeviceSpacing.medium.height,
                Text(
                  'Metabolizma hızınızı hesaplamak için bu bilgilere ihtiyacımız var.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.s48),

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
                    if (value == null || value.isEmpty) {
                      return 'Lütfen yaşınızı girin';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 10 || age > 120) {
                      return 'Geçerli bir yaş girin';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    final age = int.tryParse(value);
                    if (age != null) {
                      context.read<OnboardingWizardCubit>().updateAge(age);
                    }
                  },
                ),
                DeviceSpacing.xlarge.height,
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
                    if (value == null || value.isEmpty) {
                      return 'Lütfen boyunuzu girin';
                    }
                    final height = int.tryParse(value);
                    if (height == null || height < 50 || height > 300) {
                      return 'Geçerli bir boy girin';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    final height = int.tryParse(value);
                    if (height != null) {
                      context
                          .read<OnboardingWizardCubit>()
                          .updateHeight(height);
                    }
                  },
                ),

                const SizedBox(height: AppSizes.s48),

                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: DevicePadding.medium.onlyVertical,
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
