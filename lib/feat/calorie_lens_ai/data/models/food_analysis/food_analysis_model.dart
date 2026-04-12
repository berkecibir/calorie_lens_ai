import 'dart:convert';
import '../../../domain/entities/food_analysis/food_analysis_entity.dart';

class FoodAnalysisModel extends FoodAnalysisEntity {
  const FoodAnalysisModel({
    required super.foodName,
    required super.calories,
    required super.proteinG,
    required super.carbsG,
    required super.fatG,
    required super.portionDescription,
    required super.confidenceScore,
  });

  /// Gemini'den gelen ham JSON string'i parse eder
  factory FoodAnalysisModel.fromGeminiResponse(String rawText) {
    // Gemini bazen ```json ... ``` içinde döner, temizle
    final cleaned =
        rawText.replaceAll('```json', '').replaceAll('```', '').trim();

    final Map<String, dynamic> json = jsonDecode(cleaned);

    return FoodAnalysisModel(
      foodName: json['food_name'] ?? 'Bilinmeyen',
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0,
      carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0,
      fatG: (json['fat_g'] as num?)?.toDouble() ?? 0,
      portionDescription: json['portion'] ?? '',
      confidenceScore: (json['confidence'] as num?)?.toDouble() ?? 0.5,
    );
  }

  FoodAnalysisEntity toEntity() => FoodAnalysisEntity(
        foodName: foodName,
        calories: calories,
        proteinG: proteinG,
        carbsG: carbsG,
        fatG: fatG,
        portionDescription: portionDescription,
        confidenceScore: confidenceScore,
      );
}
