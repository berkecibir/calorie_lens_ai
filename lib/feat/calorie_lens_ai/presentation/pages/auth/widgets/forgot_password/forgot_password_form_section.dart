import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_text_form_field.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/auth_action_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendResetLink;

  const ForgotPasswordFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSendResetLink,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthTextFormField.email(
            controller: emailController,
          ),
          DeviceSpacing.large.height,
          AuthActionButton(
            onPressed: onSendResetLink,
            text: AppTexts.sendResetLinkButtonText,
            icon: Icons.send_rounded,
          ),
          DeviceSpacing.medium.height,
          TextButton(
            onPressed: () => Navigation.ofPop(),
            child: Text(
              AppTexts.backToSignInText,
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
