import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/meal_log/meal_log_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/meal_log/meal_log_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/meal_log/meal_log_repository.dart';
import 'package:dartz/dartz.dart';

class MealLogRepositoryImpl implements MealLogRepository {
  final MealLogRemoteDataSource remoteDataSource;

  MealLogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> saveMealLog(MealLogEntity mealLog) async {
    try {
      await remoteDataSource.saveMealLog(MealLogModel.fromEntity(mealLog));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealLogEntity>>> getDailyMealLogs(
      String userId, DateTime date) async {
    try {
      final logs = await remoteDataSource.getDailyMealLogs(userId, date);
      return Right(logs);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
