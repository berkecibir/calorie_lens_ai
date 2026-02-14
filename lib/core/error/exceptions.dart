class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});

  @override
  String toString() => message;
}

class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});

  @override
  String toString() => message;
}

class NutritionCalculationException implements Exception {
  final String message;
  const NutritionCalculationException({required this.message});

  @override
  String toString() => message;
}
