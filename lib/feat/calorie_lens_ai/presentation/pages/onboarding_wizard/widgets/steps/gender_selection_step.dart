import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';

class GenderSelectionStep extends StatelessWidget {
  final VoidCallback? onNext; // Optional, if we want to bubble up navigation

  const GenderSelectionStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final cubit = context.read<OnboardingWizardCubit>();

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        Gender? currentGender;
        if (state is OnboardingWizardLoaded) {
          currentGender = state.userProfile.gender;
        }

        return Padding(
          padding: const EdgeInsets.all(24.0), //bak buna
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cinsiyetiniz?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Doğru kalori hesaplaması için cinsiyetinizi bilmemiz gerekiyor.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _GenderCard(
                        icon: Icons.male,
                        label: 'Erkek',
                        isSelected: currentGender == Gender.male,
                        onTap: () => context
                            .read<OnboardingWizardCubit>()
                            .updateGender(Gender.male),
                      ),
                    ),
                    DeviceSpacing.xlarge.width,
                    Expanded(
                      child: _GenderCard(
                          icon: Icons.female,
                          label: 'Kadın',
                          isSelected: currentGender == Gender.female,
                          onTap: () => context
                              .read<OnboardingWizardCubit>()
                              .updateGender(Gender.female)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: currentGender != null ? onNext : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Devam Et'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color:
              isSelected ? theme.colorScheme.primaryContainer : theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: theme.textTheme.titleLarge?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
