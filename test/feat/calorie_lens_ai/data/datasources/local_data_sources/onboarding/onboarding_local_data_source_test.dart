import 'package:calorie_lens_ai_app/core/utils/const/onboarding_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding/onboarding_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferencesHelper])
void main() {
  late OnboardingLocalDataSourceImpl dataSource;
  late MockSharedPreferencesHelper mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferencesHelper();
    dataSource = OnboardingLocalDataSourceImpl(
      sharedPreferencesHelper: mockSharedPreferences,
    );
  });

  group('checkOnboardingStatus', () {
    test('should return true when onboarding is completed', () async {
      // Arrange
      when(mockSharedPreferences.getBool(any)).thenAnswer((_) async => true);

      // Act
      final result = await dataSource.checkOnboardingStatus();

      // Assert
      verify(mockSharedPreferences.getBool(
        OnboardingTexts.onboardingCompletedLocalKey,
      ));
      expect(result, true);
    });

    test('should return false when onboarding is not completed', () async {
      // Arrange
      when(mockSharedPreferences.getBool(any)).thenAnswer((_) async => false);

      // Act
      final result = await dataSource.checkOnboardingStatus();

      // Assert
      expect(result, false);
    });

    test('should return false when value is null (default)', () async {
      // Arrange
      when(mockSharedPreferences.getBool(any)).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.checkOnboardingStatus();

      // Assert
      expect(result, false);
    });
  });

  group('completeOnboarding', () {
    test('should save true to SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async => {});

      // Act
      await dataSource.completeOnboarding();

      // Assert
      verify(mockSharedPreferences.setBool(
        OnboardingTexts.onboardingCompletedLocalKey,
        true,
      ));
    });
  });
}
