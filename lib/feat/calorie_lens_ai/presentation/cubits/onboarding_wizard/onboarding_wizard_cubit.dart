import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/check_onboarding_wizard_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/complete_onboarding_wizard.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/save_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/calculate_and_save_nutrition_data.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingWizardCubit extends Cubit<OnboardingWizardState> {
  final GetUserProfile getUserProfile;
  final SaveUserProfile saveUserProfile;
  final CalculateAndSaveNutritionData calculateAndSaveNutritionData;
  final CheckOnboardingWizardStatus checkOnboardingWizardStatus;
  final CompleteOnboardingWizard completeOnboardingWizardUseCase;

  UserProfileEntity userProfile = UserProfileEntity.empty();

  OnboardingWizardCubit({
    required this.getUserProfile,
    required this.saveUserProfile,
    required this.calculateAndSaveNutritionData,
    required this.checkOnboardingWizardStatus,
    required this.completeOnboardingWizardUseCase,
  }) : super(OnboardingWizardInitial());

  Future<void> loadUserProfile() async {
    emit(OnboardingWizardLoading());

    final result = await getUserProfile(NoParams());
    result.fold(
      (failure) => emit(
        OnboardingWizardError(
          message: "Profil yüklenemedi: ${failure.toString()}",
        ),
      ),
      (profile) {
        userProfile = profile;
        emit(OnboardingWizardProfileUpdated(profile));
      },
    );
  }

  Future<void> checkWizardStatus() async {
    emit(OnboardingWizardLoading());

    final result = await checkOnboardingWizardStatus(NoParams());
    result.fold(
      (failure) => emit(
        OnboardingWizardError(
          message: "Wizard durumu kontrol edilemedi: ${failure.toString()}",
        ),
      ),
      (isCompleted) {
        if (isCompleted) {
          emit(
            OnboardingWizardsSuccess(
              message: "Wizard zaten tamamlanmış",
            ),
          );
        } else {
          emit(const OnboardingWizardNotCompleted(isCompleted: false));
        }
      },
    );
  }

  /// ✅ Tüm onboarding akışını tamamlar
  Future<void> finishOnboardingWizard() async {
    emit(OnboardingWizardLoading());

    // 1️⃣ Profil kaydet
    final saveResult = await saveUserProfile(userProfile);
    if (saveResult.isLeft()) {
      emit(
        OnboardingWizardError(
          message: "Profil kaydedilemedi",
        ),
      );
      return;
    }

    // 2️⃣ Besin değerlerini hesapla & kaydet
    final nutritionResult = await calculateAndSaveNutritionData(userProfile);
    if (nutritionResult.isLeft()) {
      emit(
        OnboardingWizardError(
          message: "Besin değerleri hesaplanamadı",
        ),
      );
      return;
    }

    // 3️⃣ Wizard tamamlandı işaretle
    final completeResult = await completeOnboardingWizardUseCase(NoParams());
    completeResult.fold(
      (failure) => emit(
        OnboardingWizardError(
          message: "Wizard durumu güncellenemedi",
        ),
      ),
      (_) => emit(
        OnboardingWizardsSuccess(
          message: "Wizard başarıyla tamamlandı!",
        ),
      ),
    );
  }

  // ✅ Sayfa değişimi
  void pageChanged(int newPage) {
    emit(OnboardingWizardPageChanged(newPage));
  }

  // ✅ Profil güncelleme
  void updateUserProfile(UserProfileEntity updatedProfile) {
    userProfile = updatedProfile;
    emit(OnboardingWizardProfileUpdated(userProfile));
  }
}
