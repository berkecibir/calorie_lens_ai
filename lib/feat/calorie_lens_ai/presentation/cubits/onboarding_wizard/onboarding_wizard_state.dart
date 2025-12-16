import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class OnboardingWizardState extends Equatable {
  const OnboardingWizardState();
  @override
  List<Object> get props => [];
}

class OnboardingWizardInitial extends OnboardingWizardState {
  const OnboardingWizardInitial();
  @override
  List<Object> get props => [];
}

class OnboardingWizardLoading extends OnboardingWizardState {
  const OnboardingWizardLoading();
  @override
  List<Object> get props => [];
}

class OnboardingWizardLoaded extends OnboardingWizardState {
  final UserProfileEntity userProfile;
  final int currentPageIndex;

  const OnboardingWizardLoaded({
    required this.userProfile,
    this.currentPageIndex = 0,
  });

  OnboardingWizardLoaded copyWith({
    UserProfileEntity? userProfile,
    int? currentPageIndex,
  }) {
    return OnboardingWizardLoaded(
      userProfile: userProfile ?? this.userProfile,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
  @override
  List<Object> get props => [userProfile, currentPageIndex];
}


class OnboardingWizardCompleted extends OnboardingWizardState {
  const OnboardingWizardCompleted();
  @override
  List<Object> get props => [];
}

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
  @override
  List<Object> get props => [message];
}

class OnboardingWizardsSuccess extends OnboardingWizardState {
  final String message;
  const OnboardingWizardsSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class OnboardingWizardNotCompleted extends OnboardingWizardState {
  final bool isCompleted;

  const OnboardingWizardNotCompleted({required this.isCompleted});
  @override
  List<Object> get props => [isCompleted];
}
