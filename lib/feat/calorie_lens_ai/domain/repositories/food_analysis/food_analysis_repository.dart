import 'dart:io';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/food_analysis/food_analysis_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FoodAnalysisRepository {
  Future<Either<Failure, FoodAnalysisEntity>> analyzeFood(File imageFile);
}
