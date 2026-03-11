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
    final imageBytes = await imageFile.readAsBytes();
    final mimeType = imageFile.path.toLowerCase().endsWith('.png')
        ? 'image/png'
        : 'image/jpeg';

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

    // Model bazen ```json ... ``` bloğu içine alabiliyor,
    // bunu temizlemezsen jsonDecode hata verir.
    final cleanJson =
        text.replaceAll('```json', '').replaceAll('```', '').trim();

    return FoodAnalysisModel.fromGeminiResponse(cleanJson);
  }
}
