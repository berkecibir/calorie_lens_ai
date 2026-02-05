import 'package:bloc_test/bloc_test.dart';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/complete_onboarding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_cubit_test.mocks.dart';

@GenerateMocks([
  CheckOnboardingStatus,
  CompleteOnboarding,
])
void main() {
  late OnboardingCubit cubit;
  late MockCheckOnboardingStatus mockCheckOnboardingStatus;
  late MockCompleteOnboarding mockCompleteOnboarding;

  setUp(() {
    mockCheckOnboardingStatus = MockCheckOnboardingStatus();
    mockCompleteOnboarding = MockCompleteOnboarding();

    cubit = OnboardingCubit(
      checkOnboardingStatus: mockCheckOnboardingStatus,
      completeOnboarding: mockCompleteOnboarding,
    );
  });

  group('checkInitialScreen', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [OnboardingLoading, OnboardingCompleted] when onboarding is completed',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.checkInitialScreen(),
      expect: () => [
        isA<OnboardingLoading>(),
        isA<OnboardingCompleted>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [OnboardingLoading, OnboardingPageChanged(0)] when onboarding is not completed',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.checkInitialScreen(),
      expect: () => [
        isA<OnboardingLoading>(),
        isA<OnboardingPageChanged>().having(
          (state) => state.currentPage,
          'currentPage',
          0,
        ),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [OnboardingLoading, OnboardingError] when failure occurs',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Left(CacheFailure('Error')));
        return cubit;
      },
      act: (cubit) => cubit.checkInitialScreen(),
      expect: () => [
        isA<OnboardingLoading>(),
        isA<OnboardingError>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
      },
    );
  });

  group('completeOnboardingProcess', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [OnboardingLoading, OnboardingCompleted] when completion is successful',
      build: () {
        when(mockCompleteOnboarding.call(any))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.completeOnboardingProcess(),
      expect: () => [
        isA<OnboardingLoading>(),
        isA<OnboardingCompleted>(),
      ],
      verify: (_) {
        verify(mockCompleteOnboarding.call(NoParams())).called(1);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [OnboardingLoading, OnboardingError] when failure occurs',
      build: () {
        when(mockCompleteOnboarding.call(any))
            .thenAnswer((_) async => const Left(CacheFailure('Error')));
        return cubit;
      },
      act: (cubit) => cubit.completeOnboardingProcess(),
      expect: () => [
        isA<OnboardingLoading>(),
        isA<OnboardingError>(),
      ],
      verify: (_) {
        verify(mockCompleteOnboarding.call(NoParams())).called(1);
      },
    );
  });

  group('pageChanged', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit OnboardingPageChanged with new page index',
      build: () => cubit,
      act: (cubit) => cubit.pageChanged(2),
      expect: () => [
        isA<OnboardingPageChanged>().having(
          (state) => state.currentPage,
          'currentPage',
          2,
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit OnboardingPageChanged for page 0',
      build: () => cubit,
      act: (cubit) => cubit.pageChanged(0),
      expect: () => [
        isA<OnboardingPageChanged>().having(
          (state) => state.currentPage,
          'currentPage',
          0,
        ),
      ],
    );
  });
}
