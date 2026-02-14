import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_onboarding_status_test.mocks.dart';

@GenerateMocks([OnboardingRepository])
void main() {
  late CheckOnboardingStatusImpl useCase;
  late MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = MockOnboardingRepository();
    useCase = CheckOnboardingStatusImpl(repository: mockRepository);
  });

  test(
    'should return true when onboarding is completed',
    () async {
      // Arrange
      when(mockRepository.checkOnboardingStatus())
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.checkOnboardingStatus());
      expect(result, const Right(true));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return false when onboarding is not completed',
    () async {
      // Arrange
      when(mockRepository.checkOnboardingStatus())
          .thenAnswer((_) async => const Right(false));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.checkOnboardingStatus());
      expect(result, const Right(false));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return CacheFailure when repository call fails',
    () async {
      // Arrange
      const tFailure = CacheFailure('Failed to check onboarding status');
      when(mockRepository.checkOnboardingStatus())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.checkOnboardingStatus());
      expect(result, const Left(tFailure));
    },
  );
}
