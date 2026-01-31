import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_size/device_size.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/home/home_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_pages.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/pages/onboarding_wizard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  static const String id = AppTexts.splashPageId;
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Initialize DeviceSize only once when widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DeviceSize.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<SplashCubit, SplashState>(
      listener: _handleNavigationState,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: _SplashContent(
            colorScheme: colorScheme,
            theme: theme,
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

/// Extracted splash content for better performance
class _SplashContent extends StatelessWidget {
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _SplashContent({
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App Logo
        Icon(
          Icons.restaurant_menu,
          size: 100,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 24),

        // App Name
        Text(
          'CalorieLens AI',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 48),

        // Loading Indicator
        CircularProgressIndicator(
          color: colorScheme.primary,
        ),
      ],
    );
  }
}
