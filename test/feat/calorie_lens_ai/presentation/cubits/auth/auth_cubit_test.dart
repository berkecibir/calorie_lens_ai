import 'package:bloc_test/bloc_test.dart';
import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_in_with_email_and_password.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_out.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_up_with_email_and_password.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/send_password_reset_email.dart';

@GenerateMocks([
  SignInWithEmailAndPassword,
  SignUpWithEmailAndPassword,
  SignOut,
  GetCurrentUser,
  SendPasswordResetEmail,
])
void main() {
  late AuthCubit cubit;
  late MockSignInWithEmailAndPassword mockSignIn;
  late MockSignUpWithEmailAndPassword mockSignUp;
  late MockSignOut mockSignOut;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockSendPasswordResetEmail mockSendPasswordResetEmail;

  setUp(() {
    mockSignIn = MockSignInWithEmailAndPassword();
    mockSignUp = MockSignUpWithEmailAndPassword();
    mockSignOut = MockSignOut();
    mockGetCurrentUser = MockGetCurrentUser();
    mockSendPasswordResetEmail = MockSendPasswordResetEmail();

    cubit = AuthCubit(
      signInWithEmailAndPassword: mockSignIn,
      signUpWithEmailAndPassword: mockSignUp,
      signOut: mockSignOut,
      getCurrentUser: mockGetCurrentUser,
      sendPasswordResetEmail: mockSendPasswordResetEmail,
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

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tDisplayName = 'Test User';

  group('checkAuthStatus', () {
    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, Authenticated] when user is authenticated',
      build: () {
        when(mockGetCurrentUser.call(any))
            .thenAnswer((_) async => Right(tUserEntity));
        return cubit;
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>().having(
          (state) => state.user,
          'user',
          tUserEntity,
        ),
      ],
      verify: (_) {
        verify(mockGetCurrentUser.call(NoParams())).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, Unauthenticated] when user is null',
      build: () {
        when(mockGetCurrentUser.call(any))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
      verify: (_) {
        verify(mockGetCurrentUser.call(NoParams())).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, Unauthenticated] when failure occurs',
      build: () {
        when(mockGetCurrentUser.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Error')));
        return cubit;
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
      verify: (_) {
        verify(mockGetCurrentUser.call(NoParams())).called(1);
      },
    );
  });

  group('signUp', () {
    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, Authenticated] when sign up is successful',
      build: () {
        when(mockSignUp.call(any)).thenAnswer((_) async => Right(tUserEntity));
        return cubit;
      },
      act: (cubit) => cubit.signUp(
        email: tEmail,
        password: tPassword,
        displayName: tDisplayName,
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>().having(
          (state) => state.user,
          'user',
          tUserEntity,
        ),
      ],
      verify: (_) {
        verify(mockSignUp.call(argThat(
          predicate<SignUpParams>((params) =>
              params.email == tEmail &&
              params.password == tPassword &&
              params.displayName == tDisplayName),
        ))).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, AuthError] when sign up fails',
      build: () {
        when(mockSignUp.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Sign up error')));
        return cubit;
      },
      act: (cubit) => cubit.signUp(
        email: tEmail,
        password: tPassword,
        displayName: tDisplayName,
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (state) => state.message,
          'message',
          contains('Sign up error'),
        ),
      ],
    );
  });

  group('signIn', () {
    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, Authenticated] when sign in is successful',
      build: () {
        when(mockSignIn.call(any)).thenAnswer((_) async => Right(tUserEntity));
        return cubit;
      },
      act: (cubit) => cubit.signIn(
        email: tEmail,
        password: tPassword,
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>().having(
          (state) => state.user,
          'user',
          tUserEntity,
        ),
      ],
      verify: (_) {
        verify(mockSignIn.call(argThat(
          predicate<SignInParams>((params) =>
              params.email == tEmail && params.password == tPassword),
        ))).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, AuthError] when sign in fails',
      build: () {
        when(mockSignIn.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Sign in error')));
        return cubit;
      },
      act: (cubit) => cubit.signIn(
        email: tEmail,
        password: tPassword,
      ),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (state) => state.message,
          'message',
          contains('Sign in error'),
        ),
      ],
    );
  });

  group('logOut', () {
    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, Unauthenticated] when logout is successful',
      build: () {
        when(mockSignOut.call(any)).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.logOut(),
      expect: () => [
        isA<AuthLoading>(),
        isA<Unauthenticated>(),
      ],
      verify: (_) {
        verify(mockSignOut.call(NoParams())).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, AuthError] when logout fails',
      build: () {
        when(mockSignOut.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Logout error')));
        return cubit;
      },
      act: (cubit) => cubit.logOut(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (state) => state.message,
          'message',
          contains('Logout error'),
        ),
      ],
    );
  });

  group('resetPassword', () {
    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, PasswordResetMailSent] when success',
      build: () {
        when(mockSendPasswordResetEmail.call(any))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.resetPassword(tEmail),
      expect: () => [
        isA<AuthLoading>(),
        isA<PasswordResetMailSent>(),
      ],
      verify: (_) {
        verify(mockSendPasswordResetEmail.call(argThat(
          predicate<PasswordResetParams>((params) => params.email == tEmail),
        ))).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLoading, AuthError] when failure',
      build: () {
        when(mockSendPasswordResetEmail.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Error')));
        return cubit;
      },
      act: (cubit) => cubit.resetPassword(tEmail),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (state) => state.message,
          'message',
          contains('Error'),
        ),
      ],
    );
  });
}
