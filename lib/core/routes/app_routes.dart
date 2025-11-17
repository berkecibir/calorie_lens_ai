import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SignUpPage.id: (context) => const SignUpPage(),
    SignInPage.id: (context) => const SignInPage(),
  };
}
