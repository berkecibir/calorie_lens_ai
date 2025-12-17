import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SendPasswordResetEmail implements UseCase<void, PasswordResetParams> {
  final AuthRepository repository;

  SendPasswordResetEmail({required this.repository});

  @override
  Future<Either<Failure, void>> call(PasswordResetParams params) async {
    return await repository.sendPasswordResetEmail(params.email);
  }
}

class PasswordResetParams {
  final String email;

  PasswordResetParams({required this.email});
}
