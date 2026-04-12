import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/utils/nutrition_calculator/nutrition_calculator.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/meal_log/get_daily_meal_logs.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  final GetCurrentUser getCurrentUser;
  final GetUserProfile getUserProfile;
  final GetDailyMealLogs getDailyMealLogs;

  MainCubit({
    required this.getCurrentUser,
    required this.getUserProfile,
    required this.getDailyMealLogs,
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
      (user) async {
        // 3. Günlük yemek kayıtlarını çek
        final logsResult = await getDailyMealLogs(
          GetDailyMealLogsParams(userId: user?.uid ?? '', date: DateTime.now()),
        );

        int cCal = 0, cProt = 0, cCarb = 0, cFat = 0;
        logsResult.fold(
          (f) => null, // Hata olsa da 0 ile devam et
          (logs) {
            for (var log in logs) {
              cCal += log.calories;
              cProt += log.proteinG.toInt();
              cCarb += log.carbsG.toInt();
              cFat += log.fatG.toInt();
            }
          },
        );

        profileResult.fold(
          (failure) {
            emit(MainLoaded(
              userName: user?.displayName ?? 'Kullanıcı',
              dailyCalorieGoal: 0,
              proteinTarget: 0,
              carbTarget: 0,
              fatTarget: 0,
              consumedCalories: cCal,
              consumedProtein: cProt,
              consumedCarbs: cCarb,
              consumedFat: cFat,
              todayMeals: const [],
              insightMessage:
                  'Kişiselleştirilmiş hedefler için profil bilgilerini tamamlayın.',
            ));
          },
          (profile) {
            try {
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
                consumedCalories: cCal,
                consumedProtein: cProt,
                consumedCarbs: cCarb,
                consumedFat: cFat,
                todayMeals: logsResult.getOrElse(() => []),
                insightMessage: nutritionData['insightMessage'] ?? '',
              ));
            } catch (e) {
              emit(MainLoaded(
                userName: user?.displayName ?? 'Kullanıcı',
                dailyCalorieGoal: 0,
                proteinTarget: 0,
                carbTarget: 0,
                fatTarget: 0,
                consumedCalories: cCal,
                consumedProtein: cProt,
                consumedCarbs: cCarb,
                consumedFat: cFat,
                todayMeals: logsResult.getOrElse(() => []),
                insightMessage:
                    'Kişiselleştirilmiş hedefler için profil bilgilerini tamamlayın.',
              ));
            }
          },
        );
      },
    );
  }
}
