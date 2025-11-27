import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String labelText;
  final bool isObscure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const AuthTextFormField({
    super.key,
    required this.labelText,
    required this.isObscure,
    required this.textInputType,
    required this.textInputAction,
    required this.autovalidateMode,
    this.controller,
    this.validator,
  });

  factory AuthTextFormField.email({
    required String? Function(String? email) validator,
    TextEditingController? controller,
  }) {
    return AuthTextFormField(
      labelText: AppTexts.emailLabelText,
      isObscure: false,
      controller: controller,
      validator: validator,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      obscureText: isObscure,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
    );
  }
}
