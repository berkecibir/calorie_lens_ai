import 'package:calorie_lens_ai_app/core/injection/injection_container.dart'
    as di;
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/password_visibility_cubit.dart';

class BlocProviderSetUp {
  static final providers = [
    BlocProvider<OnboardingCubit>(
      create: (_) => di.sl<OnboardingCubit>()..checkInitialScreen(),
    ),
    BlocProvider<AuthCubit>(
      create: (_) => di.sl<AuthCubit>()..checkAuthStatus(),
    ),
    BlocProvider<PasswordVisibilityCubit>(
      create: (_) => di.sl<PasswordVisibilityCubit>(),
    ),
  ];
}
