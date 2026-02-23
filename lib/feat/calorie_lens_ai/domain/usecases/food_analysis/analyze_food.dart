import 'dart:io';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/food_analysis/food_analysis_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/food_analysis/food_analysis_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AnalyzeFood extends UseCase<FoodAnalysisEntity, AnalyzeFoodParams> {
  final FoodAnalysisRepository repository;

  AnalyzeFood({required this.repository});

  @override
  Future<Either<Failure, FoodAnalysisEntity>> call(AnalyzeFoodParams params) {
    return repository.analyzeFood(params.imageFile);
  }
}

class AnalyzeFoodParams extends Equatable {
  final File imageFile;
  const AnalyzeFoodParams({required this.imageFile});
  @override
  List<Object?> get props => [imageFile];
}
