import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/auth/auth_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/auth/auth_local_data_source_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding/onboarding_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding/onboarding_local_data_source_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_wizard/onboarding_wizard_local_data_source_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/auth/auth_remote_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/remote_data_sources/auth/auth_remote_data_source_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/auth/auth_repository_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/onboarding_wizard/onboarding_wizard_repository_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/auth/auth_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding_wizard/onboarding_wizard_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/send_email_verification.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_in_with_email_and_password.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_out.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/sign_up_with_email_and_password.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/complete_onboarding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/check_onboarding_wizard_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/complete_onboarding_wizard.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/get_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/save_user_profile.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding_wizard/calculate_and_save_nutrition_data.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
// Gerekli Firebase importları
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feat/calorie_lens_ai/presentation/cubits/auth/password_visibility_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  // ---
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => SharedPreferencesHelper(sl()));

  // 🚀 Firebase Instances (YENİ EKLENENLER)
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data Sources
  // ---
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sharedPreferencesHelper: sl()),
  );

  // Yeni eklenen data source
  sl.registerLazySingleton<OnboardingWizardLocalDataSource>(
    () => OnboardingWizardLocalDataSourceImpl(sharedPreferencesHelper: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    // Artık FirebaseAuth ve FirebaseFirestore GetIt'te kayıtlı
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // Repositories
  // ---
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<OnboardingWizardRepository>(
    () => OnboardingWizardRepositoryImpl(sl(), firestore: sl(), auth: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases (Onboarding & Auth)
  // ---
  // Onboarding
  sl.registerLazySingleton<CheckOnboardingStatus>(
    () => CheckOnboardingStatusImpl(repository: sl()),
  );
  sl.registerLazySingleton<CompleteOnboarding>(
    () => CompleteOnboardingImpl(repository: sl()),
  );

  // Yeni eklenen use caseler
  // Onboarding Wizard
  sl.registerLazySingleton<GetUserProfile>(
    () => GetUserProfile(repository: sl()),
  );
  sl.registerLazySingleton<SaveUserProfile>(
    () => SaveUserProfile(repository: sl()),
  );
  sl.registerLazySingleton<CalculateAndSaveNutritionData>(
    () => CalculateAndSaveNutritionData(repository: sl()),
  );

  sl.registerLazySingleton<CheckOnboardingWizardStatus>(
    () => CheckOnboardingWizardStatusImpl(repository: sl()),
  );
  sl.registerLazySingleton<CompleteOnboardingWizard>(
    () => CompleteOnboardingWizardImpl(repository: sl()),
  );

  // Auth
  sl.registerLazySingleton<SignInWithEmailAndPassword>(
    () => SignInWithEmailAndPassword(repository: sl()),
  );

  sl.registerLazySingleton<SignUpWithEmailAndPassword>(
    () => SignUpWithEmailAndPassword(repository: sl()),
  );

  sl.registerLazySingleton<SignOut>(
    () => SignOut(repository: sl()),
  );

  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(repository: sl()),
  );

  sl.registerLazySingleton<SendEmailVerification>(
    () => SendEmailVerification(repository: sl()),
  );

  // Cubits
  // ---
  sl.registerFactory(
    () =>
        OnboardingCubit(checkOnboardingStatus: sl(), completeOnboarding: sl()),
  );

  // Yeni eklenen cubit
  sl.registerFactory(() => OnboardingWizardCubit(
        getUserProfile: sl(),
        saveUserProfile: sl(),
        calculateAndSaveNutritionData: sl(),
        checkOnboardingWizardStatus: sl(),
        completeOnboardingWizardUseCase: sl(),
      ));

  sl.registerFactory(
    () => AuthCubit(
      signInWithEmailAndPassword: sl(),
      signUpWithEmailAndPassword: sl(),
      signOut: sl(),
      getCurrentUser: sl(),
    ),
  );

  sl.registerFactory(() => PasswordVisibilityCubit());

  await Future<void>.value();
}
