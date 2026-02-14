import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_in_with_email_and_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_with_email_and_password_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInWithEmailAndPassword useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInWithEmailAndPassword(repository: mockRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tUserEntity = UserEntity(
    uid: '123',
    email: tEmail,
    displayName: 'Test User',
    photoUrl: null,
    isEmailVerified: true,
    createdAt: DateTime(2023, 1, 1),
  );

  test(
    'should call repository.signInWithEmailPassword with correct parameters',
    () async {
      // Arrange
      when(mockRepository.signInWithEmailPassword(any, any))
          .thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await useCase(SignInParams(
        email: tEmail,
        password: tPassword,
      ));

      // Assert
      verify(mockRepository.signInWithEmailPassword(tEmail, tPassword));
      expect(result, Right(tUserEntity));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return ServerFailure when repository call fails',
    () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Sign in failed');
      when(mockRepository.signInWithEmailPassword(any, any))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(SignInParams(
        email: tEmail,
        password: tPassword,
      ));

      // Assert
      verify(mockRepository.signInWithEmailPassword(tEmail, tPassword));
      expect(result, const Left(tFailure));
    },
  );
}
