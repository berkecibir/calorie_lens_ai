import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/onboarding_wizard/user_profile_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProfileModel', () {
    final tUserProfileModel = UserProfileModel(
      gender: Gender.male,
      age: 30,
      heightCm: 180,
      weightKg: 80.5,
      targetWeightKg: 75.0,
      activityLevel: ActivityLevel.moderate,
      dietType: 'Normal',
      allergies: ['Peanuts', 'Shellfish'],
    );

    final tUserProfileEntity = UserProfileEntity(
      gender: Gender.male,
      age: 30,
      heightCm: 180,
      weightKg: 80.5,
      targetWeightKg: 75.0,
      activityLevel: ActivityLevel.moderate,
      dietType: 'Normal',
      allergies: ['Peanuts', 'Shellfish'],
    );

    group('fromJson / toJson', () {
      test('should correctly serialize to JSON', () {
        // Act
        final result = tUserProfileModel.toJson();

        // Assert
        expect(result, {
          AppTexts.gender: 'male',
          AppTexts.activityLevel: 'moderate',
          AppTexts.age: 30,
          AppTexts.heightCm: 180,
          AppTexts.weightKg: 80.5,
          AppTexts.targetWeightKg: 75.0,
          AppTexts.dietType: 'Normal',
          AppTexts.allergies: ['Peanuts', 'Shellfish'],
        });
      });

      test('should correctly deserialize from JSON', () {
        // Arrange
        final json = {
          AppTexts.gender: 'male',
          AppTexts.activityLevel: 'moderate',
          AppTexts.age: 30,
          AppTexts.heightCm: 180,
          AppTexts.weightKg: 80.5,
          AppTexts.targetWeightKg: 75.0,
          AppTexts.dietType: 'Normal',
          AppTexts.allergies: ['Peanuts', 'Shellfish'],
        };

        // Act
        final result = UserProfileModel.fromJson(json);

        // Assert
        expect(result.gender, Gender.male);
        expect(result.activityLevel, ActivityLevel.moderate);
        expect(result.age, 30);
        expect(result.heightCm, 180);
        expect(result.weightKg, 80.5);
        expect(result.targetWeightKg, 75.0);
        expect(result.dietType, 'Normal');
        expect(result.allergies, ['Peanuts', 'Shellfish']);
      });

      test('should handle null optional fields in JSON', () {
        // Arrange
        final json = {
          AppTexts.gender: null,
          AppTexts.activityLevel: null,
          AppTexts.age: null,
          AppTexts.heightCm: null,
          AppTexts.weightKg: null,
          AppTexts.targetWeightKg: null,
          AppTexts.dietType: null,
          AppTexts.allergies: null,
        };

        // Act
        final result = UserProfileModel.fromJson(json);

        // Assert
        expect(result.gender, null);
        expect(result.activityLevel, null);
        expect(result.age, null);
        expect(result.heightCm, null);
        expect(result.weightKg, null);
        expect(result.targetWeightKg, null);
        expect(result.dietType, null);
        expect(result.allergies, []); // Default empty list
      });

      test('should round-trip JSON serialization', () {
        // Act
        final json = tUserProfileModel.toJson();
        final result = UserProfileModel.fromJson(json);

        // Assert
        expect(result.gender, tUserProfileModel.gender);
        expect(result.activityLevel, tUserProfileModel.activityLevel);
        expect(result.age, tUserProfileModel.age);
        expect(result.heightCm, tUserProfileModel.heightCm);
        expect(result.weightKg, tUserProfileModel.weightKg);
        expect(result.targetWeightKg, tUserProfileModel.targetWeightKg);
        expect(result.dietType, tUserProfileModel.dietType);
        expect(result.allergies, tUserProfileModel.allergies);
      });

      test('should correctly serialize enum values', () {
        // Act
        final json = tUserProfileModel.toJson();

        // Assert
        expect(json[AppTexts.gender], 'male');
        expect(json[AppTexts.activityLevel], 'moderate');
      });

      test('should correctly deserialize all Gender enum values', () {
        for (final gender in Gender.values) {
          // Arrange
          final json = {
            AppTexts.gender: gender.name,
            AppTexts.activityLevel: 'moderate',
            AppTexts.age: 30,
            AppTexts.heightCm: 180,
            AppTexts.weightKg: 80.0,
            AppTexts.targetWeightKg: 75.0,
            AppTexts.dietType: 'Normal',
            AppTexts.allergies: [],
          };

          // Act
          final result = UserProfileModel.fromJson(json);

          // Assert
          expect(result.gender, gender);
        }
      });

      test('should correctly deserialize all ActivityLevel enum values', () {
        for (final activityLevel in ActivityLevel.values) {
          // Arrange
          final json = {
            AppTexts.gender: 'male',
            AppTexts.activityLevel: activityLevel.name,
            AppTexts.age: 30,
            AppTexts.heightCm: 180,
            AppTexts.weightKg: 80.0,
            AppTexts.targetWeightKg: 75.0,
            AppTexts.dietType: 'Normal',
            AppTexts.allergies: [],
          };

          // Act
          final result = UserProfileModel.fromJson(json);

          // Assert
          expect(result.activityLevel, activityLevel);
        }
      });
    });

    group('fromEntity / toEntity', () {
      test('should correctly convert to Entity', () {
        // Act
        final result = tUserProfileModel.toEntity();

        // Assert
        expect(result.gender, tUserProfileModel.gender);
        expect(result.age, tUserProfileModel.age);
        expect(result.heightCm, tUserProfileModel.heightCm);
        expect(result.weightKg, tUserProfileModel.weightKg);
        expect(result.targetWeightKg, tUserProfileModel.targetWeightKg);
        expect(result.activityLevel, tUserProfileModel.activityLevel);
        expect(result.dietType, tUserProfileModel.dietType);
        expect(result.allergies, tUserProfileModel.allergies);
      });

      test('should correctly convert from Entity', () {
        // Act
        final result = UserProfileModel.fromEntity(tUserProfileEntity);

        // Assert
        expect(result.gender, tUserProfileEntity.gender);
        expect(result.age, tUserProfileEntity.age);
        expect(result.heightCm, tUserProfileEntity.heightCm);
        expect(result.weightKg, tUserProfileEntity.weightKg);
        expect(result.targetWeightKg, tUserProfileEntity.targetWeightKg);
        expect(result.activityLevel, tUserProfileEntity.activityLevel);
        expect(result.dietType, tUserProfileEntity.dietType);
        expect(result.allergies, tUserProfileEntity.allergies);
      });

      test('should round-trip entity conversion', () {
        // Act
        final entity = tUserProfileModel.toEntity();
        final result = UserProfileModel.fromEntity(entity);

        // Assert
        expect(result.gender, tUserProfileModel.gender);
        expect(result.age, tUserProfileModel.age);
        expect(result.heightCm, tUserProfileModel.heightCm);
        expect(result.weightKg, tUserProfileModel.weightKg);
        expect(result.targetWeightKg, tUserProfileModel.targetWeightKg);
        expect(result.activityLevel, tUserProfileModel.activityLevel);
        expect(result.dietType, tUserProfileModel.dietType);
        expect(result.allergies, tUserProfileModel.allergies);
      });
    });

    group('copyWith', () {
      test('should create a copy with updated gender', () {
        // Act
        final result = tUserProfileModel.copyWith(gender: Gender.female);

        // Assert
        expect(result.gender, Gender.female);
        expect(result.age, tUserProfileModel.age);
        expect(result.heightCm, tUserProfileModel.heightCm);
      });

      test('should create a copy with updated age', () {
        // Act
        final result = tUserProfileModel.copyWith(age: 35);

        // Assert
        expect(result.age, 35);
        expect(result.gender, tUserProfileModel.gender);
      });

      test('should create a copy with updated multiple fields', () {
        // Act
        final result = tUserProfileModel.copyWith(
          age: 35,
          weightKg: 85.0,
          activityLevel: ActivityLevel.veryActive,
        );

        // Assert
        expect(result.age, 35);
        expect(result.weightKg, 85.0);
        expect(result.activityLevel, ActivityLevel.veryActive);
        expect(result.gender, tUserProfileModel.gender);
        expect(result.heightCm, tUserProfileModel.heightCm);
      });

      test('should create a copy with updated allergies list', () {
        // Act
        final newAllergies = ['Milk', 'Eggs'];
        final result = tUserProfileModel.copyWith(allergies: newAllergies);

        // Assert
        expect(result.allergies, newAllergies);
        expect(result.gender, tUserProfileModel.gender);
      });

      test('should create identical copy when no parameters provided', () {
        // Act
        final result = tUserProfileModel.copyWith();

        // Assert
        expect(result.gender, tUserProfileModel.gender);
        expect(result.age, tUserProfileModel.age);
        expect(result.heightCm, tUserProfileModel.heightCm);
        expect(result.weightKg, tUserProfileModel.weightKg);
        expect(result.targetWeightKg, tUserProfileModel.targetWeightKg);
        expect(result.activityLevel, tUserProfileModel.activityLevel);
        expect(result.dietType, tUserProfileModel.dietType);
        expect(result.allergies, tUserProfileModel.allergies);
      });

      test('should maintain immutability - original unchanged', () {
        // Arrange
        final original = UserProfileModel(
          gender: Gender.male,
          age: 30,
          heightCm: 180,
          weightKg: 80.0,
          targetWeightKg: 75.0,
          activityLevel: ActivityLevel.moderate,
          dietType: 'Normal',
          allergies: ['Peanuts'],
        );

        // Act
        final copied = original.copyWith(age: 35, weightKg: 85.0);

        // Assert
        expect(original.age, 30);
        expect(original.weightKg, 80.0);
        expect(copied.age, 35);
        expect(copied.weightKg, 85.0);
      });
    });

    group('edge cases', () {
      test('should handle empty allergies list', () {
        // Arrange
        final model = UserProfileModel(
          gender: Gender.male,
          age: 30,
          heightCm: 180,
          weightKg: 80.0,
          targetWeightKg: 75.0,
          activityLevel: ActivityLevel.moderate,
          dietType: 'Normal',
          allergies: [],
        );

        // Act
        final json = model.toJson();
        final result = UserProfileModel.fromJson(json);

        // Assert
        expect(result.allergies, []);
      });

      test('should handle null allergies defaulting to empty list', () {
        // Arrange
        const model = UserProfileModel(
          gender: Gender.male,
          age: 30,
          heightCm: 180,
          weightKg: 80.0,
          targetWeightKg: 75.0,
          activityLevel: ActivityLevel.moderate,
          dietType: 'Normal',
        );

        // Assert
        expect(model.allergies, []);
      });

      test('should handle decimal weight values', () {
        // Arrange
        final model = UserProfileModel(
          gender: Gender.female,
          age: 25,
          heightCm: 165,
          weightKg: 62.75,
          targetWeightKg: 58.25,
          activityLevel: ActivityLevel.lightlyActive,
          dietType: 'Vegetarian',
          allergies: [],
        );

        // Act
        final json = model.toJson();
        final result = UserProfileModel.fromJson(json);

        // Assert
        expect(result.weightKg, 62.75);
        expect(result.targetWeightKg, 58.25);
      });
    });
  });
}
