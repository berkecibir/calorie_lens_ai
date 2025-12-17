import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/utils/nutrition_calculator/nutrition_calculator.dart';
import 'package:dartz/dartz.dart';

class CalculateAndSaveNutritionData
    implements UseCase<void, UserProfileEntity> {
  final OnboardingWizardRepository repository;

  CalculateAndSaveNutritionData({required this.repository});

  @override
  Future<Either<Failure, void>> call(UserProfileEntity profile) async {
    try {
      // business logic to calculate nutrition data
      final nutritionData = NutritionCalculator.calculate(profile);
      // save the calculated nutrition data to repository
      return await repository.saveNutritionData(profile, nutritionData);
    } catch (e) {
      // handle any exceptions and convert to Failure
      return Left(CalculationFailure(
        message: 'Besin hesaplama hatası: ${e.toString()}',
      ));
    }
  }
}
