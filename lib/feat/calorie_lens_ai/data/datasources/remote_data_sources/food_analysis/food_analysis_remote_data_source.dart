import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/food_analysis/food_analysis_model.dart';

abstract class FoodAnalysisRemoteDataSource {
  Future<FoodAnalysisModel> analyzeFood(File imageFile);
}
