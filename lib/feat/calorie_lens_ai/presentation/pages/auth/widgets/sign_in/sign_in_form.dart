import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_text_form_field.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/auth_action_button.dart';
import 'package:flutter/material.dart';

class SignInFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignIn;

  const SignInFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Form(
      key: formKey,
      child: Column(
        children: [
          // E-posta
          AuthTextFormField.email(
            controller: emailController,
            //  validator: (email) => FormValidator.validateEmail(email),
          ),
          DeviceSpacing.medium.height,

          // Parola
          AuthTextFormField.password(
            controller: passwordController,
            //   validator: (password) => FormValidator.validatePassword(password),
          ),

          // Şifremi Unuttum
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Şifremi unuttum sayfasına git
              },
              style: TextButton.styleFrom(
                padding: DevicePadding.small.onlyVertical,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                AppTexts.signInFormForgotPasswordText,
                style: TextStyle(
                  fontSize: AppSizes.s13,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),

          DeviceSpacing.large.height,

          // Giriş Yap Butonu
          AuthActionButton(
            onPressed: onSignIn,
            text: AppTexts.signInText,
            isLoading: false,
          ),
          DeviceSpacing.medium.height,
          // Kayıt Ol Linki
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppTexts.dontHaveAccountText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigation.pushNamed(root: AppTexts.signUpPageId);
                },
                style: TextButton.styleFrom(
                  padding: DevicePadding.small.onlyHorizontal,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppTexts.signUpText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
