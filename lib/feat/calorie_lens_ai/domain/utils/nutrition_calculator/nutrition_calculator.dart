import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import '../../../../../core/error/exceptions.dart';

class NutritionCalculator {
  const NutritionCalculator._();

  static Map<String, dynamic> calculate(UserProfileEntity profile) {
    // 1. Gerekli alanların kontrolü (Mevcut yapıyı koruduk)
    if (profile.weightKg == null ||
        profile.heightCm == null ||
        profile.age == null ||
        profile.gender == null ||
        profile.targetWeightKg == null) {
      throw NutritionCalculationException(
        message: AppTexts.profileInfoNotCompleted,
      );
    }

    // 2. BMR ve TDEE Hesaplama
    double bmr;
    if (profile.gender == Gender.male) {
      bmr = (10 * profile.weightKg!) +
          (6.25 * profile.heightCm!) -
          (5 * profile.age!) +
          5;
    } else {
      bmr = (10 * profile.weightKg!) +
          (6.25 * profile.heightCm!) -
          (5 * profile.age!) -
          161;
    }

    double activityMultiplier = _getActivityMultiplier(profile.activityLevel);
    final double tdee = bmr * activityMultiplier;

    // 3. Hedef Kalori ve Insight Mesajı Belirleme
    double dailyCalorieGoal;
    String insightMessage = "Kilonuzu korumak için ideal.";
    final double diff = profile.targetWeightKg! - profile.weightKg!;

    if (diff.abs() < 1.0) {
      dailyCalorieGoal = tdee;
    } else if (diff < 0) {
      // KİLO VERME (Ağırsağlam Mantığı)
      double calculatedGoal = tdee - 500;
      if (calculatedGoal < bmr) {
        dailyCalorieGoal = bmr;
        insightMessage =
            "Metabolizmanı korumak için kalorini yaşamsal sınırın (BMR) altına düşürmedik. Yağ yakımı bu seviyede daha sağlıklı olacaktır.";
      } else {
        dailyCalorieGoal = calculatedGoal;
        insightMessage =
            "Sürdürülebilir yağ yakımı için günlük 500 kcal açık oluşturduk. Haftalık ~0.5kg kayıp hedefleniyor.";
      }
    } else {
      // KİLO ALMA
      dailyCalorieGoal = tdee + 300; // Kas kazanımı için +300-500 kcal idealdir
      insightMessage =
          "Sağlıklı kas kazanımı için TDEE üzerine küçük bir fazlalık ekledik.";
    }

    // 4. Makro Hesaplama (g/kg mantığı)
    final proteinGrams = (profile.weightKg! * 2.0).round();
    final fatGrams = (profile.weightKg! * 0.8).round();
    final remainingCals = dailyCalorieGoal - (proteinGrams * 4 + fatGrams * 9);
    final carbGrams = (remainingCals / 4).round();

    return {
      AppTexts.bmr: bmr,
      AppTexts.tdee: tdee,
      AppTexts.dailyCalorieGoal: dailyCalorieGoal,
      AppTexts.proteinGrams: proteinGrams,
      AppTexts.carbGrams: carbGrams,
      AppTexts.fatGrams: fatGrams,
      'insightMessage': insightMessage,
    };
  }

  // Aktivite Seviyesi Çarpanları (Bilimsel Standart - Harris Benedict)
  static double _getActivityMultiplier(ActivityLevel? level) {
    switch (level) {
      case ActivityLevel.sedentary:
        return 1.2;
      case ActivityLevel.lightlyActive:
        return 1.375;
      case ActivityLevel.moderate:
        return 1.55;
      case ActivityLevel.active:
        return 1.725;
      case ActivityLevel.veryActive:
        return 1.9;
      default:
        return 1.2;
    }
  }
}
