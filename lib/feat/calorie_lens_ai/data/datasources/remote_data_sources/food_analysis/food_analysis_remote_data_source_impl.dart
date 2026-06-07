import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/food_analysis/food_analysis_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/food_analysis/food_analysis_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FoodAnalysisRemoteDataSourceImpl implements FoodAnalysisRemoteDataSource {
  final GenerativeModel model;

  const FoodAnalysisRemoteDataSourceImpl({required this.model});

  static const _prompt = '''
Bu fotografin icindeki yemegi analiz et ve SADECE asagidaki JSON formatinda yanit ver. Aciklama, markdown veya ek metin yazma:
{
  "food_name": "yemek adi Turkce",
  "calories": 0,
  "protein_g": 0.0,
  "carbs_g": 0.0,
  "fat_g": 0.0,
  "portion": "1 porsiyon (~200g)",
  "confidence": 0.9
}
Eger yemek taninamiyorsa food_name'i "Taninamadi" yap ve confidence'i 0.1 yap.
''';

  @override
  Future<FoodAnalysisModel> analyzeFood(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      if (imageBytes.isEmpty) {
        throw Exception('Secilen fotograf okunamadi');
      }

      final response = await model.generateContent([
        Content.multi([
          TextPart(_prompt),
          DataPart(_mimeTypeFor(imageFile.path), imageBytes),
        ]),
      ]);

      final text = response.text;
      if (text == null || text.trim().isEmpty) {
        throw Exception('Gemini bos yanit dondurdu');
      }

      return FoodAnalysisModel.fromGeminiResponse(_extractJson(text));
    } catch (e) {
      throw Exception('Analiz sirasinda hata: $e');
    }
  }

  String _mimeTypeFor(String path) {
    final pathLower = path.toLowerCase();
    if (pathLower.endsWith('.png')) return 'image/png';
    if (pathLower.endsWith('.webp')) return 'image/webp';
    if (pathLower.endsWith('.heic')) return 'image/heic';
    if (pathLower.endsWith('.heif')) return 'image/heif';
    return 'image/jpeg';
  }

  String _extractJson(String text) {
    final cleaned = text
        .replaceAll(RegExp(r'```(?:json)?', caseSensitive: false), '')
        .replaceAll('```', '')
        .trim();
    final start = cleaned.indexOf('{');
    final end = cleaned.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return cleaned.substring(start, end + 1);
    }
    return cleaned;
  }
}
