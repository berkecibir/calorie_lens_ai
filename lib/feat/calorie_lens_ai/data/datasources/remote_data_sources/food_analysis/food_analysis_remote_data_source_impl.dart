/* import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/food_analysis/food_analysis_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/food_analysis/food_analysis_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FoodAnalysisRemoteDataSourceImpl implements FoodAnalysisRemoteDataSource {
  final GenerativeModel model;

  const FoodAnalysisRemoteDataSourceImpl({required this.model});

  static const _prompt = '''
Bu fotoğraftaki yemeği analiz et ve SADECE aşağıdaki JSON formatında yanıt ver, başka hiçbir şey yazma:
{
  "food_name": "yemek adı (Türkçe)",
  "calories": 0,
  "protein_g": 0.0,
  "carbs_g": 0.0,
  "fat_g": 0.0,
  "portion": "1 porsiyon (~200g)",
  "confidence": 0.9
}
Eğer yemek tanınamıyorsa food_name'i "Tanınamadı" yap ve confidence'ı 0.1 yap.
''';

  @override
  Future<FoodAnalysisModel> analyzeFood(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final mimeType =
        imageFile.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
    final response = await model.generateContent([
      Content.multi([
        TextPart(_prompt),
        DataPart(mimeType, imageBytes),
      ]),
    ]);
    final text = response.text;
    if (text == null || text.isEmpty) {
      throw Exception('Gemini boş yanıt döndürdü');
    }
    return FoodAnalysisModel.fromGeminiResponse(text);
  }
}
 */
import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/food_analysis/food_analysis_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/food_analysis/food_analysis_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FoodAnalysisRemoteDataSourceImpl implements FoodAnalysisRemoteDataSource {
  final GenerativeModel model;

  const FoodAnalysisRemoteDataSourceImpl({required this.model});

  static const _prompt = '''
Bu fotoğraftaki yemeği analiz et ve SADECE aşağıdaki JSON formatında yanıt ver, başka hiçbir şey yazma:
{
  "food_name": "yemek adı (Türkçe)",
  "calories": 0,
  "protein_g": 0.0,
  "carbs_g": 0.0,
  "fat_g": 0.0,
  "portion": "1 porsiyon (~200g)",
  "confidence": 0.9
}
Eğer yemek tanınamıyorsa food_name'i "Tanınamadı" yap ve confidence'ı 0.1 yap.
''';

  @override
  Future<FoodAnalysisModel> analyzeFood(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final pathLower = imageFile.path.toLowerCase();
      
      String mimeType = 'image/jpeg';
      if (pathLower.endsWith('.png')) {
        mimeType = 'image/png';
      } else if (pathLower.endsWith('.webp')) {
        mimeType = 'image/webp';
      } else if (pathLower.endsWith('.heic') || pathLower.endsWith('.heif')) {
        mimeType = 'image/heic';
      }

      final response = await model.generateContent([
        Content.multi([
          TextPart(_prompt),
          DataPart(mimeType, imageBytes),
        ]),
      ]);

      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Gemini boş yanıt döndürdü');
      }

      // JSON bloğunu metin içinden ayıkla (regex veya manuel arama ile)
      final cleanJson = _extractJson(text);

      return FoodAnalysisModel.fromGeminiResponse(cleanJson);
    } catch (e) {
      throw Exception('Analiz sırasında hata: $e');
    }
  }

  /// Metin içindeki ilk JSON bloğunu bulur
  String _extractJson(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return text.substring(start, end + 1);
    }
    // Eğer { } bulunamazsa olduğu gibi döndür (Model.fromGeminiResponse içinde temizleme devam ediyor)
    return text.replaceAll('```json', '').replaceAll('```', '').trim();
  }
}
