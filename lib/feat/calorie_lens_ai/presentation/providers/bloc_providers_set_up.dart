import 'package:calorie_lens_ai_app/core/injection/injection_container.dart'
    as di;
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding_wizard/onboarding_wizard_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth/password_visibility_cubit.dart';
import '../cubits/bottom_nav/bottom_nav_cubit.dart';

class BlocProviderSetUp {
  static final providers = [
    BlocProvider<OnboardingCubit>(
      create: (_) => di.sl<OnboardingCubit>(),
      lazy: true,
    ),
    BlocProvider<AuthCubit>(
      create: (_) => di.sl<AuthCubit>(),
      lazy: true,
    ),
    BlocProvider<PasswordVisibilityCubit>(
      create: (_) => di.sl<PasswordVisibilityCubit>(),
      lazy: true,
    ),
    BlocProvider<OnboardingWizardCubit>(
      create: (_) => di.sl<OnboardingWizardCubit>(),
      lazy: true,
    ),
    BlocProvider<SplashCubit>(
      create: (_) => di.sl<SplashCubit>()..initializeApp(),
      lazy: false,
    ),
    BlocProvider<BottomNavCubit>(
      create: (_) => di.sl<BottomNavCubit>(),
      lazy: true,
    ),
  ];
}
