import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';

import 'onboarding_wizard_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferencesHelper, Box])
void main() {
  late MockSharedPreferencesHelper mockSharedPreferences;

  setUpAll(() async {
    // Initialize Hive for testing - using a temp directory
    Hive.init('test_hive');
  });

  setUp(() {
    mockSharedPreferences = MockSharedPreferencesHelper();
  });

  final tUserProfileEntity = UserProfileEntity(
    gender: Gender.male,
    age: 30,
    heightCm: 180,
    weightKg: 80.5,
    targetWeightKg: 75.0,
    activityLevel: ActivityLevel.moderate,
    dietType: 'Normal',
    allergies: ['Peanuts'],
  );

  final tProfileJson = {
    AppTexts.gender: 'male',
    AppTexts.activityLevel: 'moderate',
    AppTexts.age: 30,
    AppTexts.heightCm: 180,
    AppTexts.weightKg: 80.5,
    AppTexts.targetWeightKg: 75.0,
    AppTexts.dietType: 'Normal',
    AppTexts.allergies: ['Peanuts'],
  };

  group('getUserProfile', () {
    test('should return UserProfileEntity when profile exists in Hive',
        () async {
      // This test requires actual Hive box operations
      // We'll use a real box for integration-level testing
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);
      await box.put(AppTexts.onboardingWizardUserProfileKey, tProfileJson);

      // Create data source with real box
      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      final result = await testDataSource.getUserProfile();

      // Assert
      expect(result.gender, Gender.male);
      expect(result.age, 30);
      expect(result.heightCm, 180);
      expect(result.weightKg, 80.5);

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });

    test('should return empty profile when no data exists', () async {
      // Arrange
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);

      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      final result = await testDataSource.getUserProfile();

      // Assert
      expect(result.gender, null);
      expect(result.age, null);

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });
  });

  group('saveUserProfile', () {
    test('should save user profile to Hive', () async {
      // Arrange
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);

      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      await testDataSource.saveUserProfile(tUserProfileEntity);

      // Assert
      final savedData = box.get(AppTexts.onboardingWizardUserProfileKey);
      expect(savedData, isNotNull);
      expect(savedData[AppTexts.age], 30);
      expect(savedData[AppTexts.gender], 'male');

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });
  });

  group('clearTempCache', () {
    test('should clear user profile from Hive', () async {
      // Arrange
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);
      await box.put(AppTexts.onboardingWizardUserProfileKey, tProfileJson);

      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      await testDataSource.clearTempCache();

      // Assert
      final data = box.get(AppTexts.onboardingWizardUserProfileKey);
      expect(data, null);

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });
  });

  group('checkOnboardingWizardStatus', () {
    test('should return true when wizard is completed', () async {
      // Arrange
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);
      await box.put(AppTexts.onboardingWizardCompletedKey, true);

      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      final result = await testDataSource.checkOnboardingWizardStatus();

      // Assert
      expect(result, true);

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });

    test('should return false when wizard is not completed', () async {
      // Arrange
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);

      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      final result = await testDataSource.checkOnboardingWizardStatus();

      // Assert
      expect(result, false);

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });
  });

  group('completeOnboardingWizard', () {
    test('should save wizard completed status to Hive', () async {
      // Arrange
      final box = await Hive.openBox(AppTexts.onboardingWizarBoxName);

      final testDataSource = OnboardingWizardLocalDataSourceImpl(
        sharedPreferencesHelper: mockSharedPreferences,
      );

      // Act
      await testDataSource.completeOnboardingWizard();

      // Assert
      final status = box.get(AppTexts.onboardingWizardCompletedKey);
      expect(status, true);

      // Cleanup
      await box.close();
      await Hive.deleteBoxFromDisk(AppTexts.onboardingWizarBoxName);
    });
  });
}
