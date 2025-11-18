import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/complete_onboarding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CheckOnboardingStatus checkOnboardingStatus;
  final CompleteOnboarding completeOnboarding;

  OnboardingCubit({
    required this.checkOnboardingStatus,
    required this.completeOnboarding,
  }) : super(OnboardingInitial());

  Future<void> checkInitialScreen() async {
    emit(OnboardingLoading());
    final failureOrStatus = await checkOnboardingStatus(NoParams());
    failureOrStatus.fold(
      (failure) => emit(
        OnboardingError(message: AppTexts.checkInitialScreenErrorMessage),
      ),
      (status) =>
          status ? emit(OnboardingCompleted()) : emit(OnboardingNotCompleted()),
    );
  }

  Future<void> completeOnboardingProcess() async {
    emit(OnboardingLoading());
    final failureOrComplete = await completeOnboarding(NoParams());
    failureOrComplete.fold(
      (failure) => emit(
        OnboardingError(message: AppTexts.completeOnboardingErrorMessage),
      ),
      (_) => emit(OnboardingCompleted()),
    );
  }
}
