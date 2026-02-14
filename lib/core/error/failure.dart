import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

// 🌐 Network Failures
class ServerFailure extends Failure {
  final String message;

  const ServerFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure();
}

// 💾 Cache Failures
class CacheFailure extends Failure {
  final String message;

  const CacheFailure([this.message = AppTexts.empty]);
  @override
  List<Object> get props => [message];
}

// 🧮 Calculation Failure
class CalculationFailure extends Failure {
  final String message;

  const CalculationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
