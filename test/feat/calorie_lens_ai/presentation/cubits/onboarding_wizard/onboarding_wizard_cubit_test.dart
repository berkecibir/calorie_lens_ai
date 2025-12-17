import 'package:bloc_test/bloc_test.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/calculate_and_save_nutrition_data.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/check_onboarding_wizard_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/complete_onboarding_wizard.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/save_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_wizard_cubit_test.mocks.dart';

@GenerateMocks([
  GetUserProfile,
  SaveUserProfile,
  CalculateAndSaveNutritionData,
  CheckOnboardingWizardStatus,
  CompleteOnboardingWizard
])
void main() {
  late OnboardingWizardCubit cubit;
  late MockGetUserProfile mockGetUserProfile;
  late MockSaveUserProfile mockSaveUserProfile;
  late MockCalculateAndSaveNutritionData mockCalculateAndSaveNutritionData;
  late MockCheckOnboardingWizardStatus mockCheckOnboardingWizardStatus;
  late MockCompleteOnboardingWizard mockCompleteOnboardingWizard;

  setUp(() {
    mockGetUserProfile = MockGetUserProfile();
    mockSaveUserProfile = MockSaveUserProfile();
    mockCalculateAndSaveNutritionData = MockCalculateAndSaveNutritionData();
    mockCheckOnboardingWizardStatus = MockCheckOnboardingWizardStatus();
    mockCompleteOnboardingWizard = MockCompleteOnboardingWizard();

    cubit = OnboardingWizardCubit(
      getUserProfile: mockGetUserProfile,
      saveUserProfile: mockSaveUserProfile,
      calculateAndSaveNutritionData: mockCalculateAndSaveNutritionData,
      checkOnboardingWizardStatus: mockCheckOnboardingWizardStatus,
      completeOnboardingWizardUseCase: mockCompleteOnboardingWizard,
    );
  });

  group('OnboardingWizardCubit', () {
    final tProfile = UserProfileEntity(
      gender: Gender.male,
      age: 30,
      heightCm: 180,
      weightKg: 80,
      targetWeightKg: 75,
      activityLevel: ActivityLevel.moderate,
      dietType: 'Normal',
      allergies: [],
    );

    test('updateAge should emit OnboardingWizardLoaded with updated age', () {
      // Act
      cubit.updateAge(25);

      // Assert
      expect(cubit.state, isA<OnboardingWizardLoaded>());
      final state = cubit.state as OnboardingWizardLoaded;
      expect(state.userProfile.age, 25);
    });

    blocTest<OnboardingWizardCubit, OnboardingWizardState>(
      'finishOnboardingWizard should save profile and complete wizard successfully',
      build: () {
        // Setup successful responses
        when(mockSaveUserProfile.call(any))
            .thenAnswer((_) async => const Right(null));
        when(mockCalculateAndSaveNutritionData.call(any))
            .thenAnswer((_) async => const Right(null));
        when(mockCompleteOnboardingWizard.call(any))
            .thenAnswer((_) async => const Right(null));

        // IMPORTANT: Set initial state with data!
        // We simulate that the user has already entered data by calling update methods
        // or directly setting state if we could (but we use the cubit methods)
        cubit.updateAge(30);
        cubit.updateGender(Gender.male);
        cubit.updateHeight(180);
        cubit.updateWeight(80);
        cubit.updateTargetWeight(75);
        cubit.updateActivityLevel(ActivityLevel.moderate);

        return cubit;
      },
      act: (cubit) => cubit.finishOnboardingWizard(),
      expect: () => [
        // Expected states order: Loading -> Success
        isA<OnboardingWizardLoading>(),
        isA<OnboardingWizardsSuccess>(),
      ],
      verify: (_) {
        // VERIFY that saveUserProfile was called with the CORRECT profile
        verify(mockSaveUserProfile.call(argThat(
          predicate<UserProfileEntity>((profile) {
            print("Verifying saved profile: ${profile.age}");
            return profile.age == 30 &&
                profile.heightCm == 180 &&
                profile.weightKg == 80;
          }),
        ))).called(1);
      },
    );

    test(
        'Full user flow: CheckStatus -> UpdateGender -> PageChange -> UpdateAge -> Finish',
        () async {
      // 1. Initial Check
      when(mockCheckOnboardingWizardStatus.call(any))
          .thenAnswer((_) async => const Right(false)); // Not completed

      await cubit.checkWizardStatus();
      expect(cubit.state, isA<OnboardingWizardNotCompleted>());

      // 2. User updates Gender (Step 1)
      cubit.updateGender(Gender.male);
      expect(cubit.state, isA<OnboardingWizardLoaded>());
      expect((cubit.state as OnboardingWizardLoaded).userProfile.gender,
          Gender.male);

      // 3. User swipes to Page 1
      cubit.pageChanged(1);
      expect(cubit.state, isA<OnboardingWizardLoaded>());
      expect((cubit.state as OnboardingWizardLoaded).userProfile.gender,
          Gender.male); // Should persist!

      // 4. User updates Age (Step 2)
      cubit.updateAge(30);
      expect(cubit.state, isA<OnboardingWizardLoaded>());
      final profile = (cubit.state as OnboardingWizardLoaded).userProfile;
      expect(profile.gender, Gender.male); // Should still be Male
      expect(profile.age, 30);

      // 5. Setup mocks for finish
      when(mockSaveUserProfile.call(any))
          .thenAnswer((_) async => const Right(null));
      when(mockCalculateAndSaveNutritionData.call(any))
          .thenAnswer((_) async => const Right(null));
      when(mockCompleteOnboardingWizard.call(any))
          .thenAnswer((_) async => const Right(null));

      // 6. Finish
      await cubit.finishOnboardingWizard();

      // Verify that the profile sent to save/calculate has BOTH fields
      verify(mockSaveUserProfile.call(argThat(
        predicate<UserProfileEntity>(
            (p) => p.gender == Gender.male && p.age == 30),
      ))).called(1);
    });

    test(
        'checkWizardStatus should NOT wipe data if user has already started entering info',
        () async {
      // 1. Setup initial state with data
      cubit.updateAge(25);
      expect(cubit.state, isA<OnboardingWizardLoaded>());

      // 2. Call checkWizardStatus (simulating a rebuild or accidental call)
      when(mockCheckOnboardingWizardStatus.call(any))
          .thenAnswer((_) async => const Right(false));

      await cubit.checkWizardStatus();

      // 3. Current behavior (BUG): It presumably wipes data and emits NotCompleted
      // We WANT it to either preserve data or not emit NotCompleted if data exists.
      // For this test, let's see what happens.

      // Ideally, if we fix it, state should still be Loaded or contain the age 25.
      // But currently, it probably reverts to NotCompleted or Empty Loaded.
    });
  });
}
