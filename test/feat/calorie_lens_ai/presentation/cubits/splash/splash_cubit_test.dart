import 'package:bloc_test/bloc_test.dart';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/check_onboarding_wizard_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([
  CheckOnboardingStatus,
  GetCurrentUser,
  CheckOnboardingWizardStatus,
])
void main() {
  late SplashCubit cubit;
  late MockCheckOnboardingStatus mockCheckOnboardingStatus;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockCheckOnboardingWizardStatus mockCheckOnboardingWizardStatus;

  setUp(() {
    mockCheckOnboardingStatus = MockCheckOnboardingStatus();
    mockGetCurrentUser = MockGetCurrentUser();
    mockCheckOnboardingWizardStatus = MockCheckOnboardingWizardStatus();

    cubit = SplashCubit(
      checkOnboardingStatus: mockCheckOnboardingStatus,
      getCurrentUser: mockGetCurrentUser,
      checkOnboardingWizardStatus: mockCheckOnboardingWizardStatus,
    );
  });

  final tUserEntity = UserEntity(
    uid: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    photoUrl: null,
    isEmailVerified: true,
    createdAt: DateTime(2023, 1, 1),
  );

  group('initializeApp', () {
    blocTest<SplashCubit, SplashState>(
      'should navigate to onboarding when onboarding is not completed',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToOnboarding>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
        verifyNever(mockGetCurrentUser.call(any));
        verifyNever(mockCheckOnboardingWizardStatus.call(any));
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should navigate to auth when onboarding is completed but user is null',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        when(mockGetCurrentUser.call(any))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToAuth>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
        verify(mockGetCurrentUser.call(NoParams())).called(1);
        verifyNever(mockCheckOnboardingWizardStatus.call(any));
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should navigate to wizard when user is authenticated but wizard is not completed',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        when(mockGetCurrentUser.call(any))
            .thenAnswer((_) async => Right(tUserEntity));
        when(mockCheckOnboardingWizardStatus.call(any))
            .thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToWizard>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
        verify(mockGetCurrentUser.call(NoParams())).called(1);
        verify(mockCheckOnboardingWizardStatus.call(NoParams())).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should navigate to home when everything is completed',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        when(mockGetCurrentUser.call(any))
            .thenAnswer((_) async => Right(tUserEntity));
        when(mockCheckOnboardingWizardStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToHome>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
        verify(mockGetCurrentUser.call(NoParams())).called(1);
        verify(mockCheckOnboardingWizardStatus.call(NoParams())).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should emit error when exception occurs',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenThrow(Exception('Test error'));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashError>().having(
          (state) => state.message,
          'message',
          contains('Test error'),
        ),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'should navigate to onboarding when onboarding status returns failure',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Left(CacheFailure('Error')));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToOnboarding>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should navigate to auth when getCurrentUser returns failure',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        when(mockGetCurrentUser.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Error')));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToAuth>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
        verify(mockGetCurrentUser.call(NoParams())).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should navigate to wizard when wizard status returns failure',
      build: () {
        when(mockCheckOnboardingStatus.call(any))
            .thenAnswer((_) async => const Right(true));
        when(mockGetCurrentUser.call(any))
            .thenAnswer((_) async => Right(tUserEntity));
        when(mockCheckOnboardingWizardStatus.call(any))
            .thenAnswer((_) async => const Left(CacheFailure('Error')));
        return cubit;
      },
      act: (cubit) => cubit.initializeApp(),
      expect: () => [
        isA<SplashLoading>(),
        isA<SplashNavigateToWizard>(),
      ],
      verify: (_) {
        verify(mockCheckOnboardingStatus.call(NoParams())).called(1);
        verify(mockGetCurrentUser.call(NoParams())).called(1);
        verify(mockCheckOnboardingWizardStatus.call(NoParams())).called(1);
      },
    );
  });
}
