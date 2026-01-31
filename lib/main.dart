import 'package:calorie_lens_ai_app/core/config/theme/app_theme.dart';
import 'package:calorie_lens_ai_app/core/injection/injection_container.dart'
    as di;
import 'package:calorie_lens_ai_app/core/init/app_init.dart';
import 'package:calorie_lens_ai_app/core/routes/app_routes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/splash/page/splash_page.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/providers/bloc_providers_set_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadEnvironment();
  await Future.wait([
    AppInit.initializeApp(),
    Hive.initFlutter(),
  ]);
  await di.init();
  runApp(const MainApp());
}

Future<void> _loadEnvironment() async {
  try {
    await dotenv.load(fileName: AppTexts.envPath);
  } on Exception catch (e) {
    debugPrint('${AppTexts.envError} $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviderSetUp.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        theme: AppTheme.darkTheme,
        navigatorKey: Navigation.navigationKey,
        routes: AppRoutes.routes,
        initialRoute: SplashPage.id,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
