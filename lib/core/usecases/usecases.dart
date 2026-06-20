import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// base interface
abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P params);
}

// without parameters usecase
abstract class NoParamsUseCase<R> {
  Future<Either<Failure, R>> call();
}

// base class for usecase params
abstract class Params extends Equatable {
  const Params();
  @override
  List<Object> get props => [];
}

// without parameters

class NoParams extends Params {
  const NoParams();
}
