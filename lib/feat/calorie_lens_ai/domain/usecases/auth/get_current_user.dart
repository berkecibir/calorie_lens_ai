import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUser implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
