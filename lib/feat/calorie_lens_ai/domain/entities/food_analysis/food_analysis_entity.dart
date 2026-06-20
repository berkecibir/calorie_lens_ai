import 'package:equatable/equatable.dart';

class FoodAnalysisEntity extends Equatable {
  final String foodName;
  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final String portionDescription;
  final double confidenceScore;

  const FoodAnalysisEntity({
    required this.foodName,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.portionDescription,
    required this.confidenceScore,
  });

  @override
  List<Object?> get props => [
        foodName,
        calories,
        proteinG,
        carbsG,
        fatG,
        portionDescription,
        confidenceScore,
      ];
}
