import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_up_with_email_and_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_with_email_and_password_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpWithEmailAndPassword useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignUpWithEmailAndPassword(repository: mockRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tDisplayName = 'Test User';
  final tUserEntity = UserEntity(
    uid: '123',
    email: tEmail,
    displayName: tDisplayName,
    photoUrl: null,
    isEmailVerified: true,
    createdAt: DateTime(2023, 1, 1),
  );

  test(
    'should call repository.signUpWithEmailAndPassoword with correct parameters',
    () async {
      // Arrange
      when(mockRepository.signUpWithEmailAndPassoword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        displayName: anyNamed('displayName'),
      )).thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await useCase(SignUpParams(
        email: tEmail,
        password: tPassword,
        displayName: tDisplayName,
      ));

      // Assert
      verify(mockRepository.signUpWithEmailAndPassoword(
        email: tEmail,
        password: tPassword,
        displayName: tDisplayName,
      ));
      expect(result, Right(tUserEntity));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return ServerFailure when repository call fails',
    () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Sign up failed');
      when(mockRepository.signUpWithEmailAndPassoword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        displayName: anyNamed('displayName'),
      )).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(SignUpParams(
        email: tEmail,
        password: tPassword,
        displayName: tDisplayName,
      ));

      // Assert
      verify(mockRepository.signUpWithEmailAndPassoword(
        email: tEmail,
        password: tPassword,
        displayName: tDisplayName,
      ));
      expect(result, const Left(tFailure));
    },
  );
}
