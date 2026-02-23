import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/food_analysis/analyze_food.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FoodAnalysisCubit extends Cubit<FoodAnalysisState> {
  final AnalyzeFood analyzeFood;
  final ImagePicker _picker = ImagePicker();
  FoodAnalysisCubit({required this.analyzeFood}) : super(FoodAnalysisInitial());

  Future<void> pickAndAnalyze(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
          source: source, imageQuality: 85, maxWidth: 1024);
      if (picked == null) return; // user iptal ederse
      emit(FoodAnalysisLoading());
      final imageFile = File(picked.path);
      final result = await analyzeFood(AnalyzeFoodParams(imageFile: imageFile));
      result.fold(
        (failure) => emit(FoodAnalysisError(message: failure.toString())),
        (entity) => emit(FoodAnalysisSuccess(result: entity, image: imageFile)),
      );
    } catch (e) {
      emit(FoodAnalysisError(message: 'Bir hata oluştu: $e'));
    }
  }

  void reset() => emit(FoodAnalysisInitial());
}
