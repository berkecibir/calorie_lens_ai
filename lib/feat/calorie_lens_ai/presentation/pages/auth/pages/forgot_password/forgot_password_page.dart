import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/core/widgets/snackbar/custom_snackbar.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/mixin/forgot_password_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_page_layouts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/forgot_password/forgot_password_form_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/forgot_password/forgot_password_logo_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/forgot_password/forgot_password_title_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/sign_in/sign_in_loading_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String id = AppTexts.forgotPasswordPageId;
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with ForgotPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthPageLayout(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Statik bölümler - Rebuild olmaz
            const ForgotPasswordLogoSection(),
            DeviceSpacing.medium.height,
            const ForgotPasswordTitleSection(),
            DeviceSpacing.large.height,

            // Dinamik bölüm - Sadece state değişince rebuild olur
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  CustomSnackbar.showError(context,
                      '${AppTexts.signInErrorOccured} ${state.message}');
                } else if (state is PasswordResetMailSent) {
                  CustomSnackbar.showSuccess(
                      context, AppTexts.resetEmailSentMessage);
                  Navigation.ofPop();
                }
              },
              buildWhen: (previous, current) =>
                  current is AuthLoading ||
                  current is AuthError ||
                  current is PasswordResetMailSent ||
                  current is AuthInitial,
              builder: (context, state) {
                if (state is AuthLoading) {
                  // Mevcut loading widget'ını yeniden kullanabiliriz
                  return const SignInLoadingSection();
                }

                return ForgotPasswordFormSection(
                  formKey: formKey,
                  emailController: emailController,
                  onSendResetLink: sendResetLink,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
