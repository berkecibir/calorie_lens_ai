import 'package:calorie_lens_ai_app/core/error/exceptions.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/helpers/firebase/firebase_error_handler.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/auth/auth_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/auth/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Future<void> deleteUserAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await _firestore
            .collection(AppTexts.firestoreTableName)
            .doc(user.uid)
            .delete();
        // Firebase Auth'tan sil
        await user.delete();
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException(message: '${AppTexts.passwordResetFailMessage} $e');
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        throw ServerException(message: AppTexts.loginFailedMessage);
      }
      // Last login timestamp'i güncelle
      await updateLastLogin(user.uid);
      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        throw ServerException(message: AppTexts.registrationFailedMessage);
      }
      // Update display name
      await user.updateDisplayName(displayName);
      await user.reload();

      // Email verification gönder
      await user.sendEmailVerification();

      // Firestore'a kullanıcı kayıt et
      final userModel = UserModel.fromFirebaseAuth(
        uid: user.uid,
        email: user.email ?? AppTexts.empty,
        displayName: displayName,
        photoUrl: user.photoURL,
        isEmailVerified: user.emailVerified,
      );

      await _firestore
          .collection(AppTexts.firestoreTableName)
          .doc(user.uid)
          .set(
            userModel.toFirestore(),
          );

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateLastLogin(String uid) async {
    try {
      await _firestore.collection(AppTexts.firestoreTableName).doc(uid).update({
        AppTexts.lastLogin: Timestamp.fromDate(DateTime.now()),
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: '${AppTexts.failedToUpdateLastLogin} ${e.message}');
    } catch (e) {
      throw ServerException(message: '${AppTexts.failedToUpdateLastLogin} $e');
    }
  }

  @override
  Future<UserModel> updateUserInfo(UserModel userModel) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw ServerException(message: AppTexts.updateUserInfoFailMessage);
      }

      // 1. Firebase Auth Kullanıcısını Güncelleme (displayName, photoURL)
      await currentUser.updateDisplayName(userModel.displayName);
      await currentUser.updatePhotoURL(userModel.photoUrl);

      // Auth'tan güncel bilgileri çek (reload gerekebilir)
      await currentUser.reload();
      final updatedAuthUser = _firebaseAuth.currentUser!;

      // 2. Firestore Belgesini Güncelleme
      final firestoreData = {
        AppTexts.displayName: userModel.displayName,
        AppTexts.photoUrl: userModel.photoUrl,
        // Diğer güncellenecek alanlar buraya eklenebilir (örn: kilo, boy)
      };

      await _firestore
          .collection(AppTexts.firestoreTableName)
          .doc(userModel.uid)
          .update(firestoreData);

      // Güncel bilgileri içeren yeni modeli döndür
      return UserModel.fromFirebaseUser(updatedAuthUser);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: '${AppTexts.userInfoFailMessage} $e');
    }
  }

  ServerException _handleAuthException(FirebaseAuthException e) {
    return ServerException(
        message: FirebaseErrorHandler.handleAuthException(e));
  }
}
