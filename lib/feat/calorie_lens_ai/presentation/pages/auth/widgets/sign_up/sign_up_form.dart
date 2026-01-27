import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/validators/form_validator.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/const/app_texts.dart';
import '../../../../../../../core/widgets/navigation_helper/navigation_helper.dart';

class SignUpFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSignUp;

  const SignUpFormSection({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Form(
      key: formKey,
      child: Column(
        children: [
          // Ad Soyad
          AuthTextFormField.fullName(
            controller: fullNameController,
          ),
          DeviceSpacing.medium.height,

          // E-posta
          AuthTextFormField.email(
            controller: emailController,
            validator: (email) => FormValidator.validateEmail(email),
          ),
          DeviceSpacing.medium.height,

          // Parola
          AuthTextFormField.password(
            controller: passwordController,
            validator: (password) => FormValidator.validatePassword(password),
          ),
          DeviceSpacing.medium.height,

          // Parola Onay
          AuthTextFormField.confirmPassword(
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
          DeviceSpacing.large.height,

          // Kayıt Ol Butonu
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onSignUp,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppTexts.signUpText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  DeviceSpacing.small.width,
                  const Icon(Icons.arrow_forward_rounded, size: AppSizes.s20),
                ],
              ),
            ),
          ),
          DeviceSpacing.medium.height,

          // Giriş Yap Linki
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppTexts.haveAccountText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigation.pushNamed(root: SignInPage.id);
                },
                style: TextButton.styleFrom(
                  padding: DevicePadding.small.onlyHorizontal,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppTexts.signInText,
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
