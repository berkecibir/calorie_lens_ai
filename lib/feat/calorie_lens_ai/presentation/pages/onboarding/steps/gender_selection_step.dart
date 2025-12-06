import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionStep extends StatelessWidget {
  final VoidCallback? onNext; // Optional, if we want to bubble up navigation

  const GenderSelectionStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<OnboardingWizardCubit>();

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        final currentGender = cubit.userProfile.gender;

        return Padding(
          padding: const EdgeInsets.all(24.0),
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
                        onTap: () => cubit.updateUserProfile(
                            cubit.userProfile.copyWith(gender: Gender.male)),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _GenderCard(
                        icon: Icons.female,
                        label: 'Kadın',
                        isSelected: currentGender == Gender.female,
                        onTap: () => cubit.updateUserProfile(
                            cubit.userProfile.copyWith(gender: Gender.female)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: currentGender != null
                    ? () {
                        // Assuming the parent page handles page switching via controller based on tree structure,
                        // But since we are inside a PageView, we might need to access the parent controller or 
                        // just assume the parent passed a callback. 
                        // However, strictly speaking, this widget is just the content.
                        // The "Next" button logic in the parent page was: "Each step will have its own Next button".
                        // So I need to implement the PageController logic here? 
                        // No, best practice: Access the parent page's controller or use a callback provided by a wrapper.
                        // BUT, to keep it loosely coupled, let's find the PageController from context if possible? No.
                        // Let's rely on finding the PageView's controller? Hard.
                        // Simple solution: `DefaultTabController` style? No.
                        // Let's use `PageController` passed down? No, too much coupling.
                        // Let's assume the parent widget `OnboardingWizardPage` exposes a method `nextPage`.
                        // Or just use `NotificationListener`?
                        // Let's keep it simple: The `OnboardingWizardPage` I wrote *doesn't* have a global next button inside the step.
                        // It expects the step to contain the button.
                        // So `onNext` callback is needed. But `OnboardingWizardPage` code I wrote initialized `_steps` as a constant list without callbacks.
                        // I will fix `OnboardingWizardPage` later to inject callbacks.
                        // For now, I'll assumme `onNext` is passed or I'll implement a `wizard_controller` later.
                        // ACTUALLY: I can use `PageController` if I pass it to the constructor.
                        // Let's stick effectively to `onNext`. I will update `OnboardingWizardPage` to build steps in `itemBuilder` and pass callbacks.
                        
                        // For now, placeholders.
                        final pageController = PageController(); // DUMMY
                        // In reality, we need to signal "Next".
                        // Use a custom ancestor widget or access via context?
                        // `OnboardingWizardPage` is the parent. We can find `_OnboardingWizardPageState` if public? No.
                        
                        // REVISION: I will change `OnboardingWizardPage` to use `PageView.builder` and pass the callback.
                        // For now, this widget accepts `onNext` in constructor.
                        onNext?.call(); 
                      }
                    : null,
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
          color: isSelected ? theme.colorScheme.primaryContainer : theme.cardColor,
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
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: theme.textTheme.titleLarge?.copyWith(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
