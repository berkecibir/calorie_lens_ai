import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/auth/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.createdAt,
    required super.email,
    super.isEmailVerified,
    super.displayName,
    super.lastLogin,
    super.photoUrl,
  });

  // Firebase Auth'tan ilk kayıt
  factory UserModel.fromFirebaseAuth({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    bool isEmailVerified = false,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      createdAt: DateTime.now(),
      displayName: displayName,
      photoUrl: photoUrl,
      isEmailVerified: isEmailVerified,
    );
  }

  // Firestore'dan okuma (Timestamp desteği ile)
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data[AppTexts.email] as String,
      displayName: data[AppTexts.displayName] as String?,
      photoUrl: data[AppTexts.photoUrl] as String?,
      createdAt: (data[AppTexts.createdAt] as Timestamp).toDate(),
      lastLogin: data[AppTexts.lastLogin] != null
          ? (data[AppTexts.lastLogin] as Timestamp).toDate()
          : null,
      isEmailVerified: data[AppTexts.isEmailVerified] as bool? ?? false,
    );
  }

  // Firestore'a yazma
  Map<String, dynamic> toFirestore() {
    return {
      AppTexts.email: email,
      AppTexts.displayName: displayName,
      AppTexts.photoUrl: photoUrl,
      AppTexts.createdAt: Timestamp.fromDate(createdAt),
      AppTexts.lastLogin:
          lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      AppTexts.isEmailVerified: isEmailVerified,
    };
  }

  // JSON serialization (SharedPreferences vb. için)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json[AppTexts.uid] as String,
        email: json[AppTexts.email] as String,
        displayName: json[AppTexts.displayName] as String?,
        photoUrl: json[AppTexts.photoUrl] as String?,
        createdAt: DateTime.parse(json[AppTexts.createdAt] as String),
        lastLogin: json[AppTexts.lastLogin] != null
            ? DateTime.parse(json[AppTexts.lastLogin] as String)
            : null,
        isEmailVerified: json[AppTexts.isEmailVerified] as bool? ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      AppTexts.uid: uid,
      AppTexts.email: email,
      AppTexts.displayName: displayName,
      AppTexts.photoUrl: photoUrl,
      AppTexts.createdAt: createdAt.toIso8601String(),
      AppTexts.lastLogin: lastLogin?.toIso8601String(),
      AppTexts.isEmailVerified: isEmailVerified,
    };
  }

  /// Firebase User nesnesinden model oluşturma (Authentication sonrası)
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastLogin: user.metadata.lastSignInTime,
      isEmailVerified: user.emailVerified,
    );
  }
}
