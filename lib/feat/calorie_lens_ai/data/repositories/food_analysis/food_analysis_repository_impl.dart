import 'dart:io';

import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/food_analysis/food_analysis_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/food_analysis/food_analysis_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/food_analysis/food_analysis_repository.dart';
import 'package:dartz/dartz.dart';

class FoodAnalysisRepositoryImpl implements FoodAnalysisRepository {
  final FoodAnalysisRemoteDataSource remoteDataSource;

  FoodAnalysisRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FoodAnalysisEntity>> analyzeFood(
      File imageFile) async {
    try {
      final model = await remoteDataSource.analyzeFood(imageFile);
      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
