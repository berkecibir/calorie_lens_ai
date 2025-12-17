import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpWithEmailAndPassword implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpWithEmailAndPassword({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUpWithEmailAndPassoword(
        email: params.email,
        password: params.password,
        displayName: params.displayName);
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String? displayName;

  SignUpParams({required this.email, required this.password, this.displayName});
}
