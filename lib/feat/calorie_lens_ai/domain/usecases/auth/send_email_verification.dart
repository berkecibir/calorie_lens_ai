import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SendEmailVerification implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SendEmailVerification({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.sendEmailVerification();
  }
}
