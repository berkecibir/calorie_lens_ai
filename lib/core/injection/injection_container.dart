import 'package:calorie_lens_ai_app/core/utils/helpers/shared/shared_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/datasources/local_data_sources/onboarding_local_data_source.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/repositories/onboarding/onboarding_repository.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/check_onboarding_status.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/onboarding/complete_onboarding.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => SharedPreferencesHelper(sl()));

  // Data Sources

  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sharedPreferencesHelper: sl()),
  );

  // Repositories

  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton<CheckOnboardingStatus>(
    () => CheckOnboardingStatusImpl(repository: sl()),
  );
  sl.registerLazySingleton<CompleteOnboarding>(
    () => CompleteOnboardingImpl(repository: sl()),
  );

  // Cubits
  sl.registerFactory(
    () =>
        OnboardingCubit(checkOnboardingStatus: sl(), completeOnboarding: sl()),
  );
  await Future<void>.value();
}
