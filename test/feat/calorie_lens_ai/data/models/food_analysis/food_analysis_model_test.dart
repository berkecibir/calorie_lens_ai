import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/food_analysis/food_analysis_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FoodAnalysisModel', () {
    test('parses a plain Gemini JSON response', () {
      const response = '''
{
  "food_name": "Mercimek corbasi",
  "calories": 180,
  "protein_g": 9,
  "carbs_g": 24,
  "fat_g": 5,
  "portion": "1 kase",
  "confidence": 0.86
}
''';

      final result = FoodAnalysisModel.fromGeminiResponse(response);

      expect(result.foodName, 'Mercimek corbasi');
      expect(result.calories, 180);
      expect(result.proteinG, 9);
      expect(result.carbsG, 24);
      expect(result.fatG, 5);
      expect(result.portionDescription, '1 kase');
      expect(result.confidenceScore, 0.86);
    });

    test('parses fenced JSON and numeric strings', () {
      const response = '''
```json
{
  "food_name": "Tavuk salata",
  "calories": "320",
  "protein_g": "31,5",
  "carbs_g": "12",
  "fat_g": "14.5",
  "portion": "1 tabak",
  "confidence": "0.91"
}
```
''';

      final result = FoodAnalysisModel.fromGeminiResponse(response);

      expect(result.foodName, 'Tavuk salata');
      expect(result.calories, 320);
      expect(result.proteinG, 31.5);
      expect(result.carbsG, 12);
      expect(result.fatG, 14.5);
      expect(result.portionDescription, '1 tabak');
      expect(result.confidenceScore, 0.91);
    });
  });
}
