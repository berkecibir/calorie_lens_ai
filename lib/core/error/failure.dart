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

class CacheFailure extends Failure {
  final String message;

  const CacheFailure(this.message);

  @override
  List<Object> get props => [message];
}
