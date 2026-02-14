import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/home/home_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_pages.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/pages/onboarding_wizard_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/splash/page/mixin/splash_page_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/splash/page/widget/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  static const String id = AppTexts.splashPageId;
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashPageMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) {
        return current is SplashNavigateToOnboarding ||
            current is SplashNavigateToAuth ||
            current is SplashNavigateToWizard ||
            current is SplashNavigateToHome ||
            current is SplashError;
      },
      listener: _handleNavigationState,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: BlocBuilder<SplashCubit, SplashState>(
            buildWhen: (previous, current) {
              // Sadece loading veya error durumunda UI rebuild olsun
              return current is SplashLoading || current is SplashError;
            },
            builder: (context, state) {
              return SplashContent(
                colorScheme: colorScheme,
                theme: theme,
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleNavigationState(BuildContext context, SplashState state) {
    if (state is SplashNavigateToOnboarding) {
      Navigation.pushReplacementNamed(root: OnboardingPages.id);
    } else if (state is SplashNavigateToAuth) {
      Navigation.pushReplacementNamed(root: SignInPage.id);
    } else if (state is SplashNavigateToWizard) {
      Navigation.pushReplacementNamed(root: OnboardingWizardPages.id);
    } else if (state is SplashNavigateToHome) {
      Navigation.pushReplacementNamed(root: HomePage.id);
    } else if (state is SplashError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }
}
