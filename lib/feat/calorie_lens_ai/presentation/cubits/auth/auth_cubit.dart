import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/send_password_reset_email.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_in_with_email_and_password.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_out.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_up_with_email_and_password.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SendPasswordResetEmail sendPasswordResetEmail;

  AuthCubit({
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.signOut,
    required this.getCurrentUser,
    required this.sendPasswordResetEmail,
  }) : super(AuthInitial());

  // Kullanıcı kayıtlı mı değil mi ?

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final failureOrUser = await getCurrentUser(NoParams());
    failureOrUser.fold(
      (failuer) => emit(Unauthenticated()),
      (user) {
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  // Şifre sıfırlama
  Future<void> resetPassword(String email) async {
    emit(const AuthLoading());

    // UseCase'i doğru parametre yapısıyla çağırıyoruz
    final result = await sendPasswordResetEmail(
      PasswordResetParams(email: email),
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (_) => emit(
          const PasswordResetMailSent()), // Bu state'i AuthState dosyasına eklemeyi unutma!
    );
  }

  // E-posta ve şifre kayıt olma
  Future<void> signUp(
      {required String email,
      required String password,
      required String displayName}) async {
    emit(AuthLoading());
    final failuerOrUser = await signUpWithEmailAndPassword(
      SignUpParams(email: email, password: password, displayName: displayName),
    );
    failuerOrUser.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) => emit(Authenticated(user: user)));
  }

  // E-posta ve şifre ile oturum açma

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    final failureOrUser = await signInWithEmailAndPassword(
      SignInParams(email: email, password: password),
    );
    failureOrUser.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) => emit(Authenticated(user: user)));
  }

  // Oturumu kapatma
  Future<void> logOut() async {
    emit(AuthLoading());
    final failureOrUser = await signOut(NoParams());
    failureOrUser.fold(
        (failure) => emit(AuthError(message: failure.toString())),
        (user) => emit(Unauthenticated()));
  }
}
