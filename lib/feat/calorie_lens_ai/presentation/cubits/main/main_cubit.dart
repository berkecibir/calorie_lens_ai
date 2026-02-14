import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/utils/nutrition_calculator/nutrition_calculator.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  final GetCurrentUser getCurrentUser;
  final GetUserProfile getUserProfile;
  MainCubit({
    required this.getCurrentUser,
    required this.getUserProfile,
  }) : super(MainInitial());

  // load main screen data

  Future<void> loadMainScreenData() async {
    emit(MainLoading());

    // 1. Kullanıcı ismini çek (Firebase Auth'tan)
    final userResult = await getCurrentUser(NoParams());
    // 2. Profil bilgilerini çek (Local Storage'dan: yaş, kilo, boy vb.)
    final profileResult = await getUserProfile(NoParams());

    userResult.fold(
      (failure) => emit(MainError(message: 'Kullanıcı bilgileri alınamadı')),
      (user) {
        profileResult.fold(
          (failure) => emit(MainError(message: 'Profil bilgileri alınamadı')),
          (profile) {
            try {
              // 3. Hesaplamayı yap (NutritionCalculator halihazırda var!)
              // Bu hesaplama yaş, kilo, boy, cinsiyet ve aktivite seviyesine göre yapılır.
              final nutritionData = NutritionCalculator.calculate(profile);
              emit(MainLoaded(
                userName: user?.displayName ?? 'Kullanıcı',
                dailyCalorieGoal:
                    (nutritionData[AppTexts.dailyCalorieGoal] as num)
                        .toDouble(),
                proteinTarget:
                    (nutritionData[AppTexts.proteinGrams] as num).toInt(),
                carbTarget: (nutritionData[AppTexts.carbGrams] as num).toInt(),
                fatTarget: (nutritionData[AppTexts.fatGrams] as num).toInt(),
                consumedCalories: 0, // Henüz yemek takibi yok
              ));
            } catch (e) {
              emit(const MainError(
                  message: "Profil bilgileri eksik, lütfen tamamlayın."));
            }
          },
        );
      },
    );
  }
}
