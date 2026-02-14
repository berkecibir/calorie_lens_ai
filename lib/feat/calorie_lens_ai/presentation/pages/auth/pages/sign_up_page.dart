import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/core/widgets/snackbar/custom_snackbar.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/mixin/sign_up_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_page_layouts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/sign_up/sign_up_form.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/sign_up/sign_up_loading_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/sign_up/sign_up_logo_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/sign_up/sign_up_title_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/onboarding_wizard/pages/onboarding_wizard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static const String id = AppTexts.signUpPageId;
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpMixin {
  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sabit widget'lar - Sayfa açıldığında 1 kez çizilir, asla rebuild olmazlar.
          const SignUpLogoSection(),
          DeviceSpacing.medium.height,
          const SignUpTitleSection(),
          DeviceSpacing.large.height,

          // Sadece değişen kısım: Loading veya Form
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                CustomSnackbar.showError(
                    context, '${AppTexts.signUpErrorOccured} ${state.message}');
              } else if (state is Authenticated) {
                Navigation.pushReplacementNamed(root: OnboardingWizardPages.id);
              }
            },
            // buildWhen ekleyerek gereksiz UI güncellemelerini tamamen durduruyoruz
            buildWhen: (previous, current) =>
                current is AuthLoading ||
                current is AuthError ||
                current is Unauthenticated ||
                current is AuthInitial,
            builder: (context, state) {
              if (state is AuthLoading) {
                return const SignUpLoadingSection();
              }

              // Sadece form alanı rebuild olur
              return SignUpFormSection(
                formKey: key,
                fullNameController: fullNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                onSignUp: signUp,
              );
            },
          ),
        ],
      ),
    );
  }
}
