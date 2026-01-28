import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/border/app_border_radius.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/validators/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/auth/password_visibility_cubit.dart';

class AuthTextFormField extends StatelessWidget {
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
    required String? Function(String? email) validator,
    TextEditingController? controller,
  }) {
    return AuthTextFormField(
      labelText: AppTexts.emailLabelText,
      isObscure: false,
      controller: controller,
      validator: validator,
      suffix: Icons.email,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  factory AuthTextFormField.password({
    required String? Function(String? password) validator,
    TextEditingController? controller,
  }) {
    return AuthTextFormField(
        labelText: AppTexts.passwordLabelText,
        isObscure: true,
        controller: controller,
        validator: validator,
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
      labelText: AppTexts
          .confirmPasswordLabelText, // 'Parola Onay' için yeni bir text tanımlayabilirsiniz
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
      suffix: Icons.person_rounded, // Opsiyonel olarak ikon ekleyebiliriz
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordField = textInputType == TextInputType.visiblePassword;

    return isPasswordField
        ? BlocProvider(
            create: (_) => PasswordVisibilityCubit(),
            child: buildTextField(context, isPasswordField),
          )
        : buildTextField(context, isPasswordField);
  }

  Widget buildTextField(BuildContext context, bool isPasswordField) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isObscureState) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPasswordField ? isObscureState : isObscure,
          decoration: InputDecoration(
            suffixIconColor: Colors.grey,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.circular(AppSizes.s8),
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    icon: Icon(
                      isPasswordField
                          ? (isObscureState
                              ? Icons.visibility_off
                              : Icons.visibility)
                          : suffix,
                    ),
                    onPressed: isPasswordField
                        ? () => context.read<PasswordVisibilityCubit>().toggle()
                        : null,
                  )
                : null,
          ),
          keyboardType: textInputType,
          textInputAction: textInputAction,
          autovalidateMode: autovalidateMode,
        );
      },
    );
  }
}
