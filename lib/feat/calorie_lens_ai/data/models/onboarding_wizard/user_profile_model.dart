import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:hive/hive.dart';
import '../../../../../core/utils/const/app_texts.dart';
part 'user_profile_model.g.dart';

@HiveType(typeId: 0)
class UserProfileModel {
  @HiveField(0)
  final Gender? gender;

  @HiveField(1)
  final ActivityLevel? activityLevel;

  @HiveField(2)
  final int? age;

  @HiveField(3)
  final int? heightCm;

  @HiveField(4)
  final double? weightKg;

  @HiveField(5)
  final double? targetWeightKg;

  @HiveField(6)
  final String? dietType;

  @HiveField(7)
  final List<String> allergies;

  const UserProfileModel({
    this.gender,
    this.activityLevel,
    this.age,
    this.heightCm,
    this.weightKg,
    this.targetWeightKg,
    this.dietType,
    List<String>? allergies,
  }) : allergies = allergies ?? const [];

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      gender: entity.gender,
      activityLevel: entity.activityLevel,
      age: entity.age,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      targetWeightKg: entity.targetWeightKg,
      dietType: entity.dietType,
      allergies: entity.allergies,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      gender: gender,
      activityLevel: activityLevel,
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
      targetWeightKg: targetWeightKg,
      dietType: dietType,
      allergies: allergies,
    );
  }

  UserProfileModel copyWith({
    Gender? gender,
    ActivityLevel? activityLevel,
    int? age,
    int? heightCm,
    double? weightKg,
    double? targetWeightKg,
    String? dietType,
    List<String>? allergies,
  }) {
    return UserProfileModel(
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

  Map<String, dynamic> toJson() {
    return {
      AppTexts.gender: gender?.name,
      AppTexts.activityLevel: activityLevel?.name,
      AppTexts.age: age,
      AppTexts.heightCm: heightCm,
      AppTexts.weightKg: weightKg,
      AppTexts.targetWeightKg: targetWeightKg,
      AppTexts.dietType: dietType,
      AppTexts.allergies: allergies,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      // Null safety ve güvenli enum eşleşmesi:
      gender: json[AppTexts.gender] != null
          ? Gender.values.firstWhere(
              (e) => e.name == json[AppTexts.gender],
              orElse: () => Gender.male, // Eşleşmezse varsayılan değer
            )
          : null,

      activityLevel: json[AppTexts.activityLevel] != null
          ? ActivityLevel.values.firstWhere(
              (e) => e.name == json[AppTexts.activityLevel],
              orElse: () => ActivityLevel.sedentary, // Varsayılan değer
            )
          : null,

      // Geriye kalan alanlar:
      age: json[AppTexts.age] as int?,
      heightCm: json[AppTexts.heightCm] as int?,
      // num? olarak cast edip toDouble() çağırmak her zaman daha güvenlidir (int gelirse patlamaz)
      weightKg: (json[AppTexts.weightKg] as num?)?.toDouble(),
      targetWeightKg: (json[AppTexts.targetWeightKg] as num?)?.toDouble(),
      dietType: json[AppTexts.dietType] as String?,
      allergies: json[AppTexts.allergies] != null
          ? List<String>.from(json[AppTexts.allergies])
          : null,
    );
  }
}
