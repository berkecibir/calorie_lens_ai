import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<OnboardingWizardCubit, OnboardingWizardState>(
      listener: (context, state) {
        // Loading sırasında burada özel işlem yapılabilir
      },
      builder: (context, state) {
        UserProfileEntity? profile;
        bool isLoading = state is OnboardingWizardLoading;
        if (state is OnboardingWizardLoaded) {
          profile = state.userProfile;
        }
        if (profile == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Özet',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Bilgilerinizi kontrol edin ve başlamaya hazır olun!',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _SummaryCard(
                title: 'Kişisel Bilgiler',
                icon: Icons.person_outline,
                children: [
                  _SummaryRow(
                      label: 'Cinsiyet',
                      value: profile.gender == Gender.male ? 'Erkek' : 'Kadın'),
                  _SummaryRow(label: 'Yaş', value: '${profile.age} Yıl'),
                  _SummaryRow(label: 'Boy', value: '${profile.heightCm} cm'),
                ],
              ),
              const SizedBox(height: 16),
              _SummaryCard(
                title: 'Hedefler',
                icon: Icons.track_changes_outlined,
                children: [
                  _SummaryRow(
                      label: 'Mevcut Kilo', value: '${profile.weightKg} kg'),
                  _SummaryRow(
                      label: 'Hedef Kilo',
                      value: '${profile.targetWeightKg} kg'),
                  _SummaryRow(
                      label: 'Aktivite',
                      value: _getActivityLabel(profile.activityLevel)),
                ],
              ),
              const SizedBox(height: 16),
              _SummaryCard(
                title: 'Beslenme',
                icon: Icons.restaurant_menu,
                children: [
                  _SummaryRow(
                      label: 'Diyet Tipi', value: profile.dietType ?? '-'),
                  if (profile.allergies.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alerjiler:',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: profile.allergies
                                .map((a) => Chip(
                                      label: Text(a,
                                          style: const TextStyle(fontSize: 10)),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 48),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<OnboardingWizardCubit>()
                        .finishOnboardingWizard();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Hesapla ve Başla'),
                ),
            ],
          ),
        );
      },
    );
  }

  String _getActivityLabel(ActivityLevel? level) {
    if (level == null) return '-';
    // Basit bir mapping, dilerseniz ActivityLevelStep'teki map'i public yapıp kullanabilirsiniz.
    switch (level) {
      case ActivityLevel.sedentary:
        return 'Hareketsiz';
      case ActivityLevel.lightlyActive:
        return 'Az Hareketli';
      case ActivityLevel.moderate:
        return 'Orta Hareketli';
      case ActivityLevel.active:
        return 'Çok Hareketli';
      case ActivityLevel.veryActive:
        return 'Aşırı Hareketli';
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SummaryCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
