import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/onboarding_wizard/user_profile_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingWizardRepositoryImpl implements OnboardingWizardRepository {
  final OnboardingWizardLocalDataSource localDataSource;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  OnboardingWizardRepositoryImpl(this.localDataSource,
      {required this.firestore, required this.auth});

  @override
  Future<Either<Failure, void>> calculateAndSaveNutritionData(
      UserProfileEntity profile) async {
    try {
      // BMR hesaplama (Mifflin-St Jeor denklemi)
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

      // TDEE hesaplama
      double activityMultiplier;
      switch (profile.activityLevel) {
        case ActivityLevel.sedentary:
          activityMultiplier = 1.2;
          break;
        case ActivityLevel.lightlyActive:
          activityMultiplier = 1.375;
          break;
        case ActivityLevel.moderate:
          activityMultiplier = 1.55;
          break;
        case ActivityLevel.active:
          activityMultiplier = 1.725;
          break;
        case ActivityLevel.veryActive:
          activityMultiplier = 1.9;
          break;
        default:
          activityMultiplier = 1.2;
      }

      final tdee = bmr * activityMultiplier;

      // Günlük kalori hedefi (hafif bir deficit varsayıyoruz)
      final dailyCalorieGoal =
          profile.weightKg! > profile.targetWeightKg! ? tdee - 500 : tdee + 500;

      // Makro besin oranları (% protein, % karbonhidrat, % yağ)
      const proteinPercentage = 0.3;
      const carbPercentage = 0.4;
      const fatPercentage = 0.3;

      final proteinGrams = (dailyCalorieGoal * proteinPercentage / 4).round();
      final carbGrams = (dailyCalorieGoal * carbPercentage / 4).round();
      final fatGrams = (dailyCalorieGoal * fatPercentage / 9).round();
      
      // Save to Local via DataSource
      await localDataSource.saveUserProfile(profile);

      // Save to Firestore
      if (auth.currentUser != null) {
        final profileModel = UserProfileModel.fromEntity(profile);
        final profileJson = profileModel.toJson();
        
        await firestore.collection('users').doc(auth.currentUser!.uid).set({
          ...profileJson, // Spread profile fields
          'bmr': bmr,
          'tdee': tdee,
          'dailyCalorieGoal': dailyCalorieGoal,
          'proteinGrams': proteinGrams,
          'carbGrams': carbGrams,
          'fatGrams': fatGrams,
          'onboardingCompleted': true,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    try {
      final profile = await localDataSource.getUserProfile();
      return Right(profile);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(
      UserProfileEntity profile) async {
    try {
      await localDataSource.saveUserProfile(profile);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
