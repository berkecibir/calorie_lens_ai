import 'package:calorie_lens_ai_app/core/init/app_init.dart';
import 'package:calorie_lens_ai_app/core/routes/app_routes.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppInit.initDeviceSize(context);
    return MaterialApp(
      navigatorKey: Navigation.navigationKey,
      routes: AppRoutes.routes,
      initialRoute: SignUpPage.id,
    );
  }
}
