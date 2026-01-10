import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/activity_level_extension.dart'; // ✅ YENİ IMPORT
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/cards/selectable_card.dart';
import '../headers/activity_level_header.dart';

class ActivityLevelStep extends StatelessWidget {
  final VoidCallback? onNext;
  const ActivityLevelStep({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      buildWhen: (previous, current) {
        if (previous is OnboardingWizardLoaded &&
            current is OnboardingWizardLoaded) {
          return previous.userProfile.activityLevel !=
              current.userProfile.activityLevel;
        }
        return previous != current;
      },
      builder: (context, state) {
        ActivityLevel? currentLevel;
        if (state is OnboardingWizardLoaded) {
          currentLevel = state.userProfile.activityLevel;
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ActivityLevelHeader(),
              DeviceSpacing.xxlarge.height,
              ...ActivityLevel.values.map((level) {
                final isSelected = currentLevel == level;
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.s12),
                  child: SelectableCard(
                    title: level.title,
                    description: level.description,
                    iconData: level.icon,
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<OnboardingWizardCubit>()
                          .updateActivityLevel(level);
                    },
                  ),
                );
              }),
              DeviceSpacing.xlarge.height,
              WizardContinueButton(
                onPressed: currentLevel != null ? onNext : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
