import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MealLogRepository {
  Future<Either<Failure, void>> saveMealLog(MealLogEntity mealLog);
  Future<Either<Failure, List<MealLogEntity>>> getDailyMealLogs(String userId, DateTime date);
}
