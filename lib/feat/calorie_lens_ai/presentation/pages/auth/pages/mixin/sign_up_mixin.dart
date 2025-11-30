import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SignUpMixin on State<SignUpPage> {
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  void signUp() {
    if (key.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      context.read<AuthCubit>().signUp(
          displayName: fullNameController.text.trim(),
          email: email,
          password: password);
    }
  }
}
