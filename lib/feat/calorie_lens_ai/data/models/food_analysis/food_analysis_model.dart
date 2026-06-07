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

  factory FoodAnalysisModel.fromGeminiResponse(String rawText) {
    final json = _decodeGeminiJson(rawText);

    return FoodAnalysisModel(
      foodName: _readString(json['food_name'], fallback: 'Bilinmeyen'),
      calories: _readNum(json['calories']).toInt(),
      proteinG: _readNum(json['protein_g']).toDouble(),
      carbsG: _readNum(json['carbs_g']).toDouble(),
      fatG: _readNum(json['fat_g']).toDouble(),
      portionDescription: _readString(json['portion']),
      confidenceScore: _readNum(json['confidence'], fallback: 0.5).toDouble(),
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

Map<String, dynamic> _decodeGeminiJson(String rawText) {
  final cleaned = rawText
      .replaceAll(RegExp(r'```(?:json)?', caseSensitive: false), '')
      .replaceAll('```', '')
      .trim();
  final decoded = jsonDecode(cleaned);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Gemini yaniti JSON nesnesi degil');
  }
  return decoded;
}

String _readString(dynamic value, {String fallback = ''}) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return fallback;
}

num _readNum(dynamic value, {num fallback = 0}) {
  if (value is num) return value;
  if (value is String) {
    return num.tryParse(value.replaceAll(',', '.')) ?? fallback;
  }
  return fallback;
}
