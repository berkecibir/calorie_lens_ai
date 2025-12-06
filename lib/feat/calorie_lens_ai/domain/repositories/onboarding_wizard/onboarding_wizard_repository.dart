import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class OnboardingWizardRepository {
  Future<Either<Failure, UserProfileEntity>> getUserProfile();
  Future<Either<Failure, void>> saveUserProfile(UserProfileEntity profile);
  Future<Either<Failure, void>> calculateAndSaveNutritionData(
      UserProfileEntity profile);
}
