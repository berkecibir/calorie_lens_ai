import 'package:calorie_lens_ai_app/core/error/failure.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/onboarding_wizard/user_profile_model.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OnboardingWizardRepositoryImpl implements OnboardingWizardRepository {
  final OnboardingWizardLocalDataSource localDataSource;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  OnboardingWizardRepositoryImpl(this.localDataSource,
      {required this.firestore, required this.auth});

  @override
  Future<Either<Failure, void>> saveNutritionData(
      UserProfileEntity profile, Map<String, dynamic> calculatedData) async {
    try {
      await localDataSource.saveUserProfile(profile);
      if (auth.currentUser != null) {
        final profileModel = UserProfileModel.fromEntity(profile);
        final profileJson = profileModel.toJson();

        await firestore.collection('users').doc(auth.currentUser!.uid).set({
          ...profileJson,
          ...calculatedData,
          'onboardingCompleted': true,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } else {
        debugPrint(
            'Warning: Kullanıcı kimliği doğrulanmamış, veritabanına kaydedilemiyor.');
      }
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    try {
      // 1. check local data
      var profile = await localDataSource.getUserProfile();

      // 2. if local data is empty and user is signed in, get data from remote
      if (profile == const UserProfileEntity(allergies: []) &&
          auth.currentUser != null) {
        final doc = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          // 3. convert Firebase data to Model
          final data = doc.data()!;
          final model = UserProfileModel.fromJson(data);

          // 4. save for next time (Cache)
          await localDataSource.saveUserProfile(model.toEntity());

          profile = model.toEntity();
        }
      }

      return Right(profile);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(
      UserProfileEntity profile) async {
    try {
      await localDataSource.saveUserProfile(profile);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkOnboardingWizardStatus() async {
    try {
      final status = await localDataSource.checkOnboardingWizardStatus();
      return Right(status);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboardingWizard() async {
    try {
      await localDataSource.completeOnboardingWizard();
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
