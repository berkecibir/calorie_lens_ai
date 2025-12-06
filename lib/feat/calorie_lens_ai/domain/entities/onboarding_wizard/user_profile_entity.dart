import 'package:equatable/equatable.dart';

enum Gender { male, female }
enum ActivityLevel { sedentary, lightlyActive, moderate, active, veryActive }

class UserProfileEntity extends Equatable {
  final Gender? gender;
  final ActivityLevel? activityLevel;
  final int? age;
  final int? heightCm;
  final double? weightKg;
  final double? targetWeightKg;
  final String? dietType;
  final List<String> allergies;

  const UserProfileEntity({
    this.gender,
    this.activityLevel,
    this.age,
    this.heightCm,
    this.weightKg,
    this.targetWeightKg,
    this.dietType,
    this.allergies = const [],
  });

  factory UserProfileEntity.empty() {
    return const UserProfileEntity(allergies: []);
  }

  UserProfileEntity copyWith({
    Gender? gender,
    ActivityLevel? activityLevel,
    int? age,
    int? heightCm,
    double? weightKg,
    double? targetWeightKg,
    String? dietType,
    List<String>? allergies,
  }) {
    return UserProfileEntity(
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      dietType: dietType ?? this.dietType,
      allergies: allergies ?? this.allergies,
    );
  }

  @override
  List<Object?> get props => [
        gender,
        activityLevel,
        age,
        heightCm,
        weightKg,
        targetWeightKg,
        dietType,
        allergies,
      ];
}
