import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';

abstract class AuthRemoteDataSource {
  // Sign Up with Email and Password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });

  // Sign In with Email and Password
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});

  // Sign out user
  Future<void> signOut();

  // Get current user from Firebase
  Future<UserModel?> getCurrentUser();

  // Send email verification
  Future<void> sendEmailVerification();

  // Delete user account
  Future<void> deleteUserAccount();

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  // Update last login timestamp
  Future<void> updateLastLogin(String uid);

  // Update user info
  Future<UserModel> updateUserInfo(UserModel user);
}
