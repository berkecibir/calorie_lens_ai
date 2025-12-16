import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/check_onboarding_wizard_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/complete_onboarding_wizard.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/save_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/calculate_and_save_nutrition_data.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingWizardCubit extends Cubit<OnboardingWizardState> {
  final GetUserProfile getUserProfile;
  final SaveUserProfile saveUserProfile;
  final CalculateAndSaveNutritionData calculateAndSaveNutritionData;
  final CheckOnboardingWizardStatus checkOnboardingWizardStatus;
  final CompleteOnboardingWizard completeOnboardingWizardUseCase;

  OnboardingWizardCubit({
    required this.getUserProfile,
    required this.saveUserProfile,
    required this.calculateAndSaveNutritionData,
    required this.checkOnboardingWizardStatus,
    required this.completeOnboardingWizardUseCase,
  }) : super(OnboardingWizardInitial());

  // profili güvenli bir şekilde almak için yardımcı metot
  UserProfileEntity _getCurrentProfile() {
    if (state is OnboardingWizardLoaded) {
      return (state as OnboardingWizardLoaded).userProfile;
    }
    return UserProfileEntity.empty();
  }

  int _getCurrentPage() {
    if (state is OnboardingWizardLoaded) {
      return (state as OnboardingWizardLoaded).currentPageIndex;
    }
    return 0;
  }

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
        emit(
          OnboardingWizardLoaded(userProfile: profile, currentPageIndex: 0),
        );
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

  // update metodları
  void updateAge(int age) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(age: age);
    emit(OnboardingWizardLoaded(
        userProfile: newProfile, currentPageIndex: _getCurrentPage()));
  }

  void updateHeight(int height) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(heightCm: height);
    emit(OnboardingWizardLoaded(
        userProfile: newProfile, currentPageIndex: _getCurrentPage()));
  }

  void updateWeight(double weight) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(weightKg: weight);

    emit(OnboardingWizardLoaded(
      userProfile: newProfile,
      currentPageIndex: _getCurrentPage(),
    ));
  }

  void updateTargetWeight(double targetWeight) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(targetWeightKg: targetWeight);

    emit(OnboardingWizardLoaded(
      userProfile: newProfile,
      currentPageIndex: _getCurrentPage(),
    ));
  }

  void updateGender(Gender gender) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(gender: gender);

    emit(OnboardingWizardLoaded(
      userProfile: newProfile,
      currentPageIndex: _getCurrentPage(),
    ));
  }

  void updateActivityLevel(ActivityLevel activityLevel) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(activityLevel: activityLevel);

    emit(OnboardingWizardLoaded(
      userProfile: newProfile,
      currentPageIndex: _getCurrentPage(),
    ));
  }

  void updateDietType(String dietType) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(dietType: dietType);

    emit(OnboardingWizardLoaded(
      userProfile: newProfile,
      currentPageIndex: _getCurrentPage(),
    ));
  }

  void updateAllergies(List<String> allergies) {
    final currentProfile = _getCurrentProfile();
    final newProfile = currentProfile.copyWith(allergies: allergies);

    emit(OnboardingWizardLoaded(
      userProfile: newProfile,
      currentPageIndex: _getCurrentPage(),
    ));
  }

  /// ✅ Tüm onboarding akışını tamamlar
  Future<void> finishOnboardingWizard() async {
    final currentProfile = _getCurrentProfile();

    emit(OnboardingWizardLoading());

    // DEBUG: Profili kontrol et
    debugPrint('📋 Profile being saved:');
    debugPrint('  - Gender: ${currentProfile.gender}');
    debugPrint('  - Age: ${currentProfile.age}');
    debugPrint('  - Height: ${currentProfile.heightCm}');
    debugPrint('  - Weight: ${currentProfile.weightKg}');
    debugPrint('  - Target Weight: ${currentProfile.targetWeightKg}');
    debugPrint('  - Activity: ${currentProfile.activityLevel}');

    // 1️⃣ Profil kaydet
    final saveResult = await saveUserProfile(currentProfile);
    if (saveResult.isLeft()) {
      emit(
        OnboardingWizardError(
          message: "Profil kaydedilemedi",
        ),
      );
      return;
    }

    // 2️⃣ Besin değerlerini hesapla & kaydet
    final nutritionResult = await calculateAndSaveNutritionData(currentProfile);
    nutritionResult.fold(
      (failure) {
        debugPrint('❌ Nutrition calculation failed: ${failure.toString()}');
        emit(
          OnboardingWizardError(
            message: "Besin hesaplama hatası: ${failure.toString()}",
          ),
        );
      },
      (_) async {
        // 3️⃣ Wizard tamamlandı işaretle
        final completeResult =
            await completeOnboardingWizardUseCase(NoParams());
        completeResult.fold(
          (failure) => emit(
            OnboardingWizardError(
              message: "Wizard durumu güncellenemedi: ${failure.toString()}",
            ),
          ),
          (_) => emit(
            OnboardingWizardsSuccess(
              message: "Wizard başarıyla tamamlandı!",
            ),
          ),
        );
      },
    );
  }



  void pageChanged(int index) {
    emit(OnboardingWizardLoaded(
        userProfile: _getCurrentProfile(), currentPageIndex: index));
  }
}
