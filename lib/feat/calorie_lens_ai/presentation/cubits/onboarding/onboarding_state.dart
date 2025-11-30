import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();
  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int currentPage;

  const OnboardingPageChanged(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class OnboardingNotCompleted extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;
  const OnboardingError({required this.message});
}
