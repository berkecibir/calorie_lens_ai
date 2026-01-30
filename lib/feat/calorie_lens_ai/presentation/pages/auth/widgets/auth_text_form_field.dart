import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/validators/form_validator.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  final String labelText;
  final bool isObscure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final IconData? suffix;
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
    this.suffix,
  });

  factory AuthTextFormField.email({
    TextEditingController? controller,
  }) {
    return AuthTextFormField(
      labelText: AppTexts.emailLabelText,
      isObscure: false,
      controller: controller,
      validator: FormValidator.validateEmail,
      suffix: Icons.email,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  factory AuthTextFormField.password({
    TextEditingController? controller,
  }) {
    return AuthTextFormField(
        labelText: AppTexts.passwordLabelText,
        isObscure: true,
        controller: controller,
        validator: FormValidator.validatePassword,
        suffix: Icons.visibility,
        textInputType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction);
  }

  factory AuthTextFormField.confirmPassword({
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) {
    return AuthTextFormField(
      labelText: AppTexts.confirmPasswordLabelText,
      isObscure: true,
      controller: confirmPasswordController,
      validator: (value) =>
          FormValidator.validateConfirmPassword(value, passwordController.text),
      suffix: Icons.visibility,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  factory AuthTextFormField.fullName({
    required TextEditingController controller,
  }) {
    return AuthTextFormField(
      labelText: AppTexts.fullNameLabelText,
      isObscure: false,
      controller: controller,
      validator: FormValidator.validateFullName,
      suffix: Icons.person_rounded,
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  late bool _isObscure;
  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObscure;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordField =
        widget.textInputType == TextInputType.visiblePassword;
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isPasswordField ? _isObscure : widget.isObscure,
      decoration: InputDecoration(
        suffixIconColor: Colors.grey,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.circular(AppSizes.s8),
        ),
        suffixIcon: widget.suffix != null
            ? IconButton(
                icon: Icon(
                  isPasswordField
                      ? (_isObscure ? Icons.visibility : Icons.visibility_off)
                      : widget.suffix,
                ),
                onPressed: isPasswordField ? _toggleVisibility : null,
              )
            : null,
      ),
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
    );
  }
}
