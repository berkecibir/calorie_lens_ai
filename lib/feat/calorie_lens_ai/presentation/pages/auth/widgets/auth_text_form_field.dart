import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/utils/validators/form_validator.dart';
import 'package:flutter/material.dart';

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
      validator: (value) {
        // 1. Önce standart parola validasyonlarını uygula
        final passwordValidation = FormValidator.validatePassword(value);
        if (passwordValidation != null) return passwordValidation;

        // 2. Parolaların eşleşip eşleşmediğini kontrol et
        if (value != passwordController.text) {
          return 'Parolalar eşleşmiyor';
        }
        return null;
      },
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
      labelText: AppTexts.fullNameLabelText, // Veya 'Ad Soyad'
      isObscure: false,
      controller: controller,
      // Ad Soyad için gerekli olan tüm ayarlar ve validasyon buraya taşındı
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Ad Soyad alanı boş bırakılamaz';
        }
        if (value.trim().length < 3) {
          return 'Ad Soyad en az 3 karakter olmalıdır';
        }
        return null;
      },
      suffix: Icons.person_rounded, // Opsiyonel olarak ikon ekleyebiliriz
      textInputType: TextInputType.name,
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
        suffixIcon: suffix != null ? Icon(suffix) : null,
        suffixIconColor: Colors.grey,
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
