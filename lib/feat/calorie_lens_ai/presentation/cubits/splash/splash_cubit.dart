import 'package:calorie_lens_ai_app/core/duration/app_duration.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/check_onboarding_wizard_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckOnboardingStatus checkOnboardingStatus;
  final GetCurrentUser getCurrentUser;
  final CheckOnboardingWizardStatus checkOnboardingWizardStatus;

  SplashCubit(
      {required this.checkOnboardingStatus,
      required this.getCurrentUser,
      required this.checkOnboardingWizardStatus})
      : super(SplashInitial());

  Future<void> initializeApp() async {
    emit(SplashLoading());

    // Give splash screen time to render smoothly
    await Future.delayed(AppDuration.medium);

    try {
      // Onboarding status kontrolü
      final onboardingResult = await checkOnboardingStatus.call(NoParams());

      final isOnboardingCompleted = onboardingResult.fold(
        (failure) => false,
        (status) => status,
      );
      if (!isOnboardingCompleted) {
        emit(SplashNavigateToOnboarding());
        return;
      }
      // 2. Kullanıcı login olmuş mu kontrol et
      final userResult = await getCurrentUser.call(NoParams());
      final user = userResult.fold(
        (failure) => null,
        (userData) => userData,
      );
      if (user == null) {
        emit(SplashNavigateToAuth());
        return;
      }
      // 3. Wizard tamamlandı mı kontrol et
      final wizardResult = await checkOnboardingWizardStatus.call(NoParams());
      final isWizardCompleted = wizardResult.fold(
        (failure) => false,
        (status) => status,
      );
      if (!isWizardCompleted) {
        emit(SplashNavigateToWizard());
        return;
      }
      // 4. Her şey tamam, ana sayfaya git
      emit(SplashNavigateToHome());
    } catch (e) {
      emit(SplashError(message: '${AppTexts.splashError} $e'));
    }
  }
}
