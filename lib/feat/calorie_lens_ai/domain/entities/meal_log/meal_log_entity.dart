import 'package:equatable/equatable.dart';

class MealLogEntity extends Equatable {
  final String id;
  final String userId;
  final String foodName;
  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final DateTime dateTime;
  final String? imageUrl; // Opsiyonel: Storage'a fotoğraf yüklenirse

  const MealLogEntity({
    required this.id,
    required this.userId,
    required this.foodName,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.dateTime,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        foodName,
        calories,
        proteinG,
        carbsG,
        fatG,
        dateTime,
        imageUrl,
      ];
}
