import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityLevelStep extends StatelessWidget {
  final VoidCallback? onNext;

  const ActivityLevelStep({super.key, this.onNext});

  static const Map<ActivityLevel, Map<String, String>> _activityDetails = {
    ActivityLevel.sedentary: {
      'title': 'Hareketsiz',
      'description': 'Masa başı iş, az veya hiç egzersiz yok.',
      'icon': 'chair',
    },
    ActivityLevel.lightlyActive: {
      'title': 'Az Hareketli',
      'description': 'Hafif egzersiz/spor (haftada 1-3 gün).',
      'icon': 'directions_walk',
    },
    ActivityLevel.moderate: {
      'title': 'Orta Hareketli',
      'description': 'Orta düzey egzersiz/spor (haftada 3-5 gün).',
      'icon': 'fitness_center',
    },
    ActivityLevel.active: {
      'title': 'Çok Hareketli',
      'description': 'Ağır egzersiz/spor (haftada 6-7 gün).',
      'icon': 'run_circle',
    },
    ActivityLevel.veryActive: {
      'title': 'Aşırı Hareketli',
      'description': 'Çok ağır egzersiz, fiziksel iş veya günde 2 antrenman.',
      'icon': 'local_fire_department',
    },
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        ActivityLevel? currentLevel;
        if (state is OnboardingWizardLoaded) {
          currentLevel = state.userProfile.activityLevel;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Aktivite Seviyesi',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Günlük aktivite seviyeniz kalori ihtiyacınızı belirler.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ...ActivityLevel.values.map((level) {
                final details = _activityDetails[level]!;
                final isSelected = currentLevel == level;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _ActivityCard(
                    title: details['title']!,
                    description: details['description']!,
                    iconData: _getIconData(details['icon']!),
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<OnboardingWizardCubit>()
                          .updateActivityLevel(level);
                    },
                  ),
                );
              }),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: currentLevel != null ? onNext : null,
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
        );
      },
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'chair':
        return Icons
            .chair_outlined; // chair exists in recent flutter? if not use weekend
      case 'directions_walk':
        return Icons.directions_walk;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'run_circle':
        return Icons.directions_run;
      case 'local_fire_department':
        return Icons.local_fire_department;
      default:
        return Icons.help_outline;
    }
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.title,
    required this.description,
    required this.iconData,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? theme.colorScheme.primaryContainer : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : theme.colorScheme.surfaceContainerHighest
                        .withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.8)
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
