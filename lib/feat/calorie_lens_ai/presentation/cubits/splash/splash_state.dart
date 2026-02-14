import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateToOnboarding extends SplashState {}

class SplashNavigateToAuth extends SplashState {}

class SplashNavigateToWizard extends SplashState {}

class SplashNavigateToHome extends SplashState {}

class SplashError extends SplashState {
  final String message;
  const SplashError({required this.message});
  @override
  List<Object?> get props => [message];
}
