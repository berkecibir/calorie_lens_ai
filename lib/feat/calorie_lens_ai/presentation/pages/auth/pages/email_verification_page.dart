import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/snackbar/custom_snackbar.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_page_layouts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/splash/page/splash_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/device_spacing/device_spacing.dart';
import '../../../../../../core/widgets/navigation_helper/navigation_helper.dart';

class EmailVerificationPage extends StatelessWidget {
  static const String id = AppTexts.emailVerificationPageId;

  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AuthPageLayout(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // SplashPage, wizard tamamlandı mı kontrolünü yapar ve doğru yere yönlendirir.
              Navigation.pushReplacementNamed(root: SplashPage.id);
            } else if (state is Unauthenticated) {
              Navigation.pushReplacementNamed(root: SignInPage.id);
            } else if (state is AuthError) {
              CustomSnackbar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mark_email_unread_outlined,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                DeviceSpacing.large.height,
                Text(
                  AppTexts.verifyEmailTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                DeviceSpacing.medium.height,
                Text(
                  AppTexts.verifyEmailDescription,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                DeviceSpacing.xxlarge.height,
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AuthCubit>().checkAuthStatus(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(AppTexts.checkVerificationButtonText),
                  ),
                  DeviceSpacing.medium.height,
                  TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().sendVerificationEmail();
                      CustomSnackbar.showSuccess(
                        context,
                        AppTexts.emailVerificationSentMessage,
                      );
                    },
                    child: const Text(AppTexts.resendEmailButtonText),
                  ),
                ],
                DeviceSpacing.large.height,
                TextButton(
                  onPressed: () => context.read<AuthCubit>().logOut(),
                  child: Text(
                    AppTexts.cancelAndLogoutButtonText,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
