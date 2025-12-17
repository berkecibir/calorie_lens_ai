import 'dart:convert';
import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/auth/auth_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';
import '../../../../../../core/error/exceptions.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userSessionKey = 'user_session';
  static const String _authTokenKey = 'auth_token';

  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthLocalDataSourceImpl(this._sharedPreferencesHelper);

  @override
  Future<void> saveUserSession(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _sharedPreferencesHelper.setString(_userSessionKey, userJson);
    } catch (e) {
      throw CacheException(message: 'Failed to save user session: $e');
    }
  }

  @override
  Future<UserModel?> getCachedUserSession() async {
    try {
      final userJson =
          await _sharedPreferencesHelper.getString(_userSessionKey);
      if (userJson == null) return null;

      final decodedJson = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(decodedJson);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached user session: $e');
    }
  }

  @override
  Future<void> clearUserSession() async {
    try {
      await _sharedPreferencesHelper.remove(_userSessionKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear user session: $e');
    }
  }

  @override
  Future<bool> isUserSessionExists() async {
    try {
      final userJson =
          await _sharedPreferencesHelper.getString(_userSessionKey);
      return userJson != null && userJson.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> updateCachedUser(UserModel user) async {
    try {
      await saveUserSession(user);
    } catch (e) {
      throw CacheException(message: 'Failed to update cached user: $e');
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await _sharedPreferencesHelper.setString(_authTokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Failed to save auth token: $e');
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      return await _sharedPreferencesHelper.getString(_authTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to get auth token: $e');
    }
  }

  @override
  Future<void> clearAuthToken() async {
    try {
      await _sharedPreferencesHelper.remove(_authTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear auth token: $e');
    }
  }
}
