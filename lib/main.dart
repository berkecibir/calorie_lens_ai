import 'package:calorie_lens_ai_app/core/injection/injection_container.dart'
    as di;
import 'package:calorie_lens_ai_app/core/init/app_init.dart';
import 'package:calorie_lens_ai_app/core/routes/app_routes.dart';
import 'package:calorie_lens_ai_app/core/widgets/navigation_helper/navigation_helper.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/providers/bloc_providers_set_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feat/calorie_lens_ai/presentation/pages/onboarding/pages/onboarding_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppInit.initDeviceSize(context);
    return MultiBlocProvider(
      providers: BlocProviderSetUp.providers,
      child: MaterialApp(
        navigatorKey: Navigation.navigationKey,
        routes: AppRoutes.routes,
        initialRoute: OnboardingPages.id,
      ),
    );
  }
}
