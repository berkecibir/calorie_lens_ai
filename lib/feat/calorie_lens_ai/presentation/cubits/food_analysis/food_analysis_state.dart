import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/food_analysis/food_analysis_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FoodAnalysisState extends Equatable {
  const FoodAnalysisState();

  @override
  List<Object?> get props => [];
}

class FoodAnalysisInitial extends FoodAnalysisState {}

class FoodAnalysisLoading extends FoodAnalysisState {}

class FoodAnalysisSuccess extends FoodAnalysisState {
  final FoodAnalysisEntity result;
  final File image;
  const FoodAnalysisSuccess({required this.result, required this.image});
  @override
  List<Object?> get props => [result, image];
}

class FoodAnalysisError extends FoodAnalysisState {
  final String message;
  const FoodAnalysisError({required this.message});
  @override
  List<Object?> get props => [message];
}
