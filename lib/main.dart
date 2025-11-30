import 'package:calorie_lens_ai_app/core/config/theme/app_theme.dart';
import 'package:calorie_lens_ai_app/core/injection/injection_container.dart'
    as di;
import 'package:calorie_lens_ai_app/core/init/app_init.dart';
import 'package:calorie_lens_ai_app/core/routes/app_routes.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/pages/sign_in_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/providers/bloc_providers_set_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: "assets/.env");
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  await AppInit.initializeApp();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviderSetUp.providers,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          AppInit.initDeviceSize(context);
          return child ?? const SizedBox.shrink();
        },
        navigatorKey: Navigation.navigationKey,
        routes: AppRoutes.routes,
        initialRoute: SignInPage.id,
      ),
    );
  }
}
