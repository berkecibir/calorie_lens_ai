import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/meal_log/meal_log_repository.dart';
import 'package:dartz/dartz.dart';

class GetDailyMealLogsParams {
  final String userId;
  final DateTime date;

  GetDailyMealLogsParams({required this.userId, required this.date});
}

class GetDailyMealLogs {
  final MealLogRepository repository;

  GetDailyMealLogs({required this.repository});

  Future<Either<Failure, List<MealLogEntity>>> call(GetDailyMealLogsParams params) {
    return repository.getDailyMealLogs(params.userId, params.date);
  }
}
