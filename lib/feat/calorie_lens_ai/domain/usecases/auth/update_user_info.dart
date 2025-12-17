import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserInfo implements UseCase<UserEntity, UpdateUserInfoParams> {
  final AuthRepository repository;

  UpdateUserInfo(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateUserInfoParams params) async {
    return await repository.updateUserInfo(params.user);
  }
}

class UpdateUserInfoParams {
  final UserEntity user;

  UpdateUserInfoParams({required this.user});
}
