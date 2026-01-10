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
import '../headers/gender_header_section.dart';

class GenderSelectionStep extends StatelessWidget {
  final VoidCallback? onNext;
  const GenderSelectionStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
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
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const GenderHeaderSection(),
                    SizedBox(height: AppSizes.s48),
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
              ),
            ],
          ),
        );
      },
    );
  }
}

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
            label: OnboardingWizardTexts.male,
            isSelected: currentGender == Gender.male,
            onTap: () =>
                context.read<OnboardingWizardCubit>().updateGender(Gender.male),
          ),
        ),
        DeviceSpacing.xlarge.width,
        Expanded(
          child: GenderCard(
            icon: Icons.female,
            label: OnboardingWizardTexts.female,
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
