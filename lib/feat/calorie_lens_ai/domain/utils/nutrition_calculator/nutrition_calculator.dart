import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';

class NutritionCalculator {
  const NutritionCalculator._();

  static Map<String, dynamic> calculate(UserProfileEntity profile) {
    // ✅ Tüm gerekli alanları kontrol et
    if (profile.weightKg == null ||
        profile.heightCm == null ||
        profile.age == null ||
        profile.gender == null ||
        profile.targetWeightKg == null) {
      throw Exception(
        "Eksik profil bilgisi: Ağırlık, boy, yaş, cinsiyet ve hedef kilo gerekli!",
      );
    }

    // 1. BMR Hesaplama (Mifflin-St Jeor)
    double bmr;
    if (profile.gender == Gender.male) {
      bmr = 10 * profile.weightKg! +
          6.25 * profile.heightCm! -
          5 * profile.age! +
          5;
    } else {
      bmr = 10 * profile.weightKg! +
          6.25 * profile.heightCm! -
          5 * profile.age! -
          161;
    }

    // 2. TDEE Hesaplama (Aktivite Çarpanı)
    double activityMultiplier = _getActivityMultiplier(profile.activityLevel);
    final tdee = bmr * activityMultiplier;

    // 3. Hedef Belirleme (Kilo alma/verme durumuna göre)
    final isWeightLoss = profile.targetWeightKg! < profile.weightKg!;
    final dailyCalorieGoal = isWeightLoss ? tdee - 500 : tdee + 500;

    // 4. Makro Dağılımı (%30 Protein, %40 Carb, %30 Fat)
    const proteinPercentage = 0.3;
    const carbPercentage = 0.4;
    const fatPercentage = 0.3;

    final proteinGrams = (dailyCalorieGoal * proteinPercentage / 4).round();
    final carbGrams = (dailyCalorieGoal * carbPercentage / 4).round();
    final fatGrams = (dailyCalorieGoal * fatPercentage / 9).round();

    return {
      'bmr': bmr,
      'tdee': tdee,
      'dailyCalorieGoal': dailyCalorieGoal,
      'proteinGrams': proteinGrams,
      'carbGrams': carbGrams,
      'fatGrams': fatGrams,
    };
  }

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
