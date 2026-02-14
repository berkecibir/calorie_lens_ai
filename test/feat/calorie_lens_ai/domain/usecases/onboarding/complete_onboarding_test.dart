import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/complete_onboarding.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'complete_onboarding_test.mocks.dart';

@GenerateMocks([OnboardingRepository])
void main() {
  late CompleteOnboardingImpl useCase;
  late MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = MockOnboardingRepository();
    useCase = CompleteOnboardingImpl(repository: mockRepository);
  });

  test(
    'should complete onboarding successfully',
    () async {
      // Arrange
      when(mockRepository.completeOnboarding())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.completeOnboarding());
      expect(result, const Right(null));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return CacheFailure when repository call fails',
    () async {
      // Arrange
      const tFailure = CacheFailure('Failed to complete onboarding');
      when(mockRepository.completeOnboarding())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      verify(mockRepository.completeOnboarding());
      expect(result, const Left(tFailure));
    },
  );
}
