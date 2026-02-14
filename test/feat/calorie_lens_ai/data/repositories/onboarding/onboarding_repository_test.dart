import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding/onboarding_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_repository_test.mocks.dart';

@GenerateMocks([OnboardingLocalDataSource])
void main() {
  late OnboardingRepositoryImpl repository;
  late MockOnboardingLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockOnboardingLocalDataSource();
    repository = OnboardingRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  group('checkOnboardingStatus', () {
    test(
      'should return true when onboarding is completed',
      () async {
        // Arrange
        when(mockLocalDataSource.checkOnboardingStatus())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.checkOnboardingStatus();

        // Assert
        verify(mockLocalDataSource.checkOnboardingStatus());
        expect(result, const Right(true));
      },
    );

    test(
      'should return false when onboarding is not completed',
      () async {
        // Arrange
        when(mockLocalDataSource.checkOnboardingStatus())
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.checkOnboardingStatus();

        // Assert
        verify(mockLocalDataSource.checkOnboardingStatus());
        expect(result, const Right(false));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.checkOnboardingStatus())
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.checkOnboardingStatus();

        // Assert
        verify(mockLocalDataSource.checkOnboardingStatus());
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });

  group('completeOnboarding', () {
    test(
      'should complete onboarding successfully',
      () async {
        // Arrange
        when(mockLocalDataSource.completeOnboarding())
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.completeOnboarding();

        // Assert
        verify(mockLocalDataSource.completeOnboarding());
        expect(result, const Right(null));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.completeOnboarding())
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.completeOnboarding();

        // Assert
        verify(mockLocalDataSource.completeOnboarding());
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });
}
