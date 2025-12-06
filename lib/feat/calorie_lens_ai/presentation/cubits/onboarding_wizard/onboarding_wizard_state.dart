import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class OnboardingWizardState extends Equatable {
  const OnboardingWizardState();
  @override
  List<Object> get props => [];
}

class OnboardingWizardInitial extends OnboardingWizardState {}

class OnboardingWizardLoading extends OnboardingWizardState {}

class OnboardingWizardCompleted extends OnboardingWizardState {}

class OnboardingWizardPageChanged extends OnboardingWizardState {
  final int currentPage;

  const OnboardingWizardPageChanged(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class OnboardingWizardProfileUpdated extends OnboardingWizardState {
  final UserProfileEntity profile;

  const OnboardingWizardProfileUpdated(this.profile);

  @override
  List<Object> get props => [profile];
}

class OnboardingWizardError extends OnboardingWizardState {
  final String message;
  const OnboardingWizardError({required this.message});
}
