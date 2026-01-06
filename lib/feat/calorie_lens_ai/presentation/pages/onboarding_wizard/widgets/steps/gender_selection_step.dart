import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/utils/const/onboardin_wizard_texts.dart';
import '../../../../../../../core/widgets/device_padding/device_padding.dart';
import '../../../../../../../core/widgets/device_spacing/device_spacing.dart';
import '../../../../widgets/cards/gender_card.dart';

class GenderSelectionStep extends StatelessWidget {
  final VoidCallback? onNext;
  const GenderSelectionStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      // ✅ YENİ: buildWhen ekle
      buildWhen: (previous, current) {
        if (previous is OnboardingWizardLoaded &&
            current is OnboardingWizardLoaded) {
          return previous.userProfile.gender != current.userProfile.gender;
        }
        return previous != current;
      },
      builder: (context, state) {
        Gender? currentGender;
        if (state is OnboardingWizardLoaded) {
          currentGender = state.userProfile.gender;
        }

        return Padding(
          padding: DevicePadding.xlarge.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ YENİ: Header'ı ayrı const widget yap
              const HeaderSection(),

              SizedBox(height: AppSizes.s48),

              // ✅ YENİ: Gender selection'ı ayrı widget yap
              Expanded(
                child: GenderSelectionRow(
                  currentGender: currentGender,
                ),
              ),

              DeviceSpacing.xxlarge.height,
              WizardContinueButton(
                onPressed: currentGender != null ? onNext : null,
                text: AppTexts.continueText,
              ),
              DeviceSpacing.medium.height,
            ],
          ),
        );
      },
    );
  }
}

// ✅ YENİ: Bu widget'ı AYNI DOSYADA ekle (en alta)
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          OnboardinWizardTexts.yourGender,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        DeviceSpacing.medium.height,
        Text(
          OnboardinWizardTexts.genderSelectionbodyTitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ✅ YENİ: Bu widget'ı da AYNI DOSYADA ekle (en alta)
class GenderSelectionRow extends StatelessWidget {
  final Gender? currentGender;

  const GenderSelectionRow({super.key, required this.currentGender});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GenderCard(
            icon: Icons.male,
            label: OnboardinWizardTexts.male,
            isSelected: currentGender == Gender.male,
            onTap: () =>
                context.read<OnboardingWizardCubit>().updateGender(Gender.male),
          ),
        ),
        DeviceSpacing.xlarge.width,
        Expanded(
          child: GenderCard(
            icon: Icons.female,
            label: OnboardinWizardTexts.female,
            isSelected: currentGender == Gender.female,
            onTap: () => context
                .read<OnboardingWizardCubit>()
                .updateGender(Gender.female),
          ),
        ),
      ],
    );
  }
}
