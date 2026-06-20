import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealLogModel extends MealLogEntity {
  const MealLogModel({
    required super.id,
    required super.userId,
    required super.foodName,
    required super.calories,
    required super.proteinG,
    required super.carbsG,
    required super.fatG,
    required super.dateTime,
    super.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foodName': foodName,
      'calories': calories,
      'proteinG': proteinG,
      'carbsG': carbsG,
      'fatG': fatG,
      'dateTime': Timestamp.fromDate(dateTime),
      'imageUrl': imageUrl,
    };
  }

  factory MealLogModel.fromJson(Map<String, dynamic> json) {
    return MealLogModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      foodName: json['foodName'] ?? '',
      calories: json['calories'] ?? 0,
      proteinG: (json['proteinG'] as num?)?.toDouble() ?? 0,
      carbsG: (json['carbsG'] as num?)?.toDouble() ?? 0,
      fatG: (json['fatG'] as num?)?.toDouble() ?? 0,
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      imageUrl: json['imageUrl'],
    );
  }

  factory MealLogModel.fromEntity(MealLogEntity entity) {
    return MealLogModel(
      id: entity.id,
      userId: entity.userId,
      foodName: entity.foodName,
      calories: entity.calories,
      proteinG: entity.proteinG,
      carbsG: entity.carbsG,
      fatG: entity.fatG,
      dateTime: entity.dateTime,
      imageUrl: entity.imageUrl,
    );
  }
}
