import 'package:calorie_lens_ai_app/core/utils/const/app_regex.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';

class FormValidator {
  // Form Validator
  static String? validateForm(String? data) {
    return (data?.isNotEmpty ?? false) ? null : AppTexts.validateFormMessage;
  }

  // Email Validator
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppTexts.validateEmailMessage;
    }
    final regex = RegExp(AppRegex.emailPattern);
    return regex.hasMatch(email) ? null : AppTexts.validateRegexcontrollMessage;
  }

  // Password Validator
  static String? validatePassword(String? password, {int minLength = 6}) {
    if (password == null || password.isEmpty) {
      return AppTexts.validatePasswordMessage;
    }
    if (password.length < minLength) {
      return AppTexts.validatePasswordLengthMessage(minLength);
    }
    return null;
  }
}
