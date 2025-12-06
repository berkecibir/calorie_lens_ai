import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/save_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/calculate_and_save_nutrition_data.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingWizardCubit extends Cubit<OnboardingWizardState> {
  final GetUserProfile getUserProfile;
  final SaveUserProfile saveUserProfile;
  final CalculateAndSaveNutritionData calculateAndSaveNutritionData;

  // Kullanıcı profili verisini tutmak için
  UserProfileEntity userProfile = UserProfileEntity.empty();

  OnboardingWizardCubit({
    required this.getUserProfile,
    required this.saveUserProfile,
    required this.calculateAndSaveNutritionData,
  }) : super(OnboardingWizardInitial());

  Future<void> loadUserProfile() async {
    emit(OnboardingWizardLoading());
    final failureOrProfile = await getUserProfile(NoParams());
    failureOrProfile.fold(
      (failure) => emit(
        OnboardingWizardError(
            message: "Profil yüklenemedi: ${failure.toString()}"),
      ),
      (profile) {
        userProfile = profile;
        emit(OnboardingWizardProfileUpdated(profile));
      },
    );
  }

  Future<void> completeOnboardingWizard() async {
    emit(OnboardingWizardLoading());

    // Önce kullanıcı profilini kaydet
    final failureOrSave = await saveUserProfile(userProfile);
    await failureOrSave.fold(
      (failure) async {
        emit(OnboardingWizardError(
            message: "Profil kaydedilemedi: ${failure.toString()}"));
        return;
      },
      (_) async {
        // Profil kaydedildikten sonra besin değerlerini hesapla ve kaydet
        final failureOrCalculate =
            await calculateAndSaveNutritionData(userProfile);
        failureOrCalculate.fold(
          (failure) {
            emit(OnboardingWizardError(
                message:
                    "Besin değerleri hesaplanamadı: ${failure.toString()}"));
          },
          (_) {
            // Tüm işlemler başarılı olduysa wizard'ı tamamla
            emit(OnboardingWizardCompleted());
          },
        );
      },
    );
  }

  // Sayfa değiştirildiğinde tetiklenir
  void pageChanged(int newPage) {
    emit(OnboardingWizardPageChanged(newPage));
  }

  // Kullanıcı profilini güncelle
  void updateUserProfile(UserProfileEntity updatedProfile) {
    userProfile = updatedProfile;
    emit(OnboardingWizardProfileUpdated(userProfile));
  }
}
