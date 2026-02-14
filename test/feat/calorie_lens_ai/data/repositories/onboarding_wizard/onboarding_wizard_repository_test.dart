import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/onboarding_wizard/onboarding_wizard_repository_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_wizard_repository_test.mocks.dart';

@GenerateMocks([
  OnboardingWizardLocalDataSource,
  FirebaseFirestore,
  FirebaseAuth,
  User,
  CollectionReference,
  DocumentReference,
])
void main() {
  late OnboardingWizardRepositoryImpl repository;
  late MockOnboardingWizardLocalDataSource mockLocalDataSource;
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionRef;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentRef;

  setUp(() {
    mockLocalDataSource = MockOnboardingWizardLocalDataSource();
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockCollectionRef = MockCollectionReference<Map<String, dynamic>>();
    mockDocumentRef = MockDocumentReference<Map<String, dynamic>>();

    repository = OnboardingWizardRepositoryImpl(
      mockLocalDataSource,
      firestore: mockFirestore,
      auth: mockAuth,
    );
  });

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

  final tCalculatedData = {
    'dailyCalories': 2000,
    'protein': 150,
    'carbs': 200,
    'fat': 65,
  };

  group('getUserProfile', () {
    test(
      'should return UserProfileEntity when local data source succeeds',
      () async {
        // Arrange
        when(mockLocalDataSource.getUserProfile())
            .thenAnswer((_) async => tProfile);

        // Act
        final result = await repository.getUserProfile();

        // Assert
        verify(mockLocalDataSource.getUserProfile());
        expect(result, Right(tProfile));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.getUserProfile())
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.getUserProfile();

        // Assert
        verify(mockLocalDataSource.getUserProfile());
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });

  group('saveUserProfile', () {
    test(
      'should save user profile successfully',
      () async {
        // Arrange
        when(mockLocalDataSource.saveUserProfile(tProfile))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.saveUserProfile(tProfile);

        // Assert
        verify(mockLocalDataSource.saveUserProfile(tProfile));
        expect(result, const Right(null));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.saveUserProfile(tProfile))
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.saveUserProfile(tProfile);

        // Assert
        verify(mockLocalDataSource.saveUserProfile(tProfile));
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });

  group('saveNutritionData', () {
    test(
      'should save nutrition data to both local and Firestore when user is authenticated',
      () async {
        // Arrange
        const tUserId = 'test-user-id';
        when(mockAuth.currentUser).thenReturn(mockUser);
        when(mockUser.uid).thenReturn(tUserId);
        when(mockLocalDataSource.saveUserProfile(any))
            .thenAnswer((_) async => {});
        when(mockFirestore.collection('users')).thenReturn(mockCollectionRef);
        when(mockCollectionRef.doc(tUserId)).thenReturn(mockDocumentRef);
        when(mockDocumentRef.set(any, any)).thenAnswer((_) async => {});

        // Act
        final result = await repository.saveNutritionData(
          tProfile,
          tCalculatedData,
        );

        // Assert
        verify(mockLocalDataSource.saveUserProfile(tProfile));
        verify(mockFirestore.collection('users'));
        verify(mockCollectionRef.doc(tUserId));
        verify(mockDocumentRef.set(any, any));
        expect(result, const Right(null));
      },
    );

    test(
      'should save only to local when user is not authenticated',
      () async {
        // Arrange
        when(mockAuth.currentUser).thenReturn(null);
        when(mockLocalDataSource.saveUserProfile(any))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.saveNutritionData(
          tProfile,
          tCalculatedData,
        );

        // Assert
        verify(mockLocalDataSource.saveUserProfile(tProfile));
        verifyNever(mockFirestore.collection(any));
        expect(result, const Right(null));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.saveUserProfile(any))
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.saveNutritionData(
          tProfile,
          tCalculatedData,
        );

        // Assert
        verify(mockLocalDataSource.saveUserProfile(tProfile));
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });

  group('checkOnboardingWizardStatus', () {
    test(
      'should return true when wizard is completed',
      () async {
        // Arrange
        when(mockLocalDataSource.checkOnboardingWizardStatus())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.checkOnboardingWizardStatus();

        // Assert
        verify(mockLocalDataSource.checkOnboardingWizardStatus());
        expect(result, const Right(true));
      },
    );

    test(
      'should return false when wizard is not completed',
      () async {
        // Arrange
        when(mockLocalDataSource.checkOnboardingWizardStatus())
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.checkOnboardingWizardStatus();

        // Assert
        verify(mockLocalDataSource.checkOnboardingWizardStatus());
        expect(result, const Right(false));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.checkOnboardingWizardStatus())
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.checkOnboardingWizardStatus();

        // Assert
        verify(mockLocalDataSource.checkOnboardingWizardStatus());
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });

  group('completeOnboardingWizard', () {
    test(
      'should complete onboarding wizard successfully',
      () async {
        // Arrange
        when(mockLocalDataSource.completeOnboardingWizard())
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.completeOnboardingWizard();

        // Assert
        verify(mockLocalDataSource.completeOnboardingWizard());
        expect(result, const Right(null));
      },
    );

    test(
      'should return CacheFailure when local data source throws exception',
      () async {
        // Arrange
        when(mockLocalDataSource.completeOnboardingWizard())
            .thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.completeOnboardingWizard();

        // Assert
        verify(mockLocalDataSource.completeOnboardingWizard());
        expect(result, isA<Left>());
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });
}
