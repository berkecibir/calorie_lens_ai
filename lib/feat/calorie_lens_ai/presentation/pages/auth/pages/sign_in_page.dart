import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/mixin/sign_in_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_page_layouts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/sign_in/sign_in_title_section.dart'
    show SignInTitleSection;
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/device_spacing/device_spacing.dart';
import '../../../../../../core/widgets/navigation_helper/navigation_helper.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/auth/auth_state.dart';
import '../widgets/sign_in/sign_in_form.dart';
import '../widgets/sign_in/sign_in_loading_section.dart';
import '../widgets/sign_in/sign_in_logo_section.dart';

class SignInPage extends StatefulWidget {
  static const String id = AppTexts.signInPageId;
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthPageLayout(
          child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Giriş Hatası: ${state.message}'),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          } else if (state is Authenticated) {
            Navigation.push(page: HomePage());
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SignInLogoSection(),
              DeviceSpacing.medium.height,
              const SignInTitleSection(),
              DeviceSpacing.large.height,
              if (state is AuthLoading)
                const SignInLoadingSection()
              else
                SignInFormSection(
                  formKey: key,
                  emailController: emailController,
                  passwordController: passwordController,
                  onSignIn: signIn,
                ),
            ],
          );
        },
      )),
    );
  }
}
