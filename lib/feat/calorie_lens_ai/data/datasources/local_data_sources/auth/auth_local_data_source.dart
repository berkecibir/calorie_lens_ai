import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';

abstract class AuthLocalDataSource {
  // Save user session locally
  Future<void> saveUserSession(UserModel user);
  // Get cached user session
  Future<UserModel?> getCachedUserSession();
  // Clear user session
  Future<void> clearUserSession();
  // Check if user session exists
  Future<bool> isUserSessionExists();
  // Update cached user data
  Future<void> updateCachedUser(UserModel user);
  // Save user auth token
  Future<void> saveAuthToken(String token);
  // Get auth token
  Future<String?> getAuthToken();
  // Clear auth token
  Future<void> clearAuthToken();
}
