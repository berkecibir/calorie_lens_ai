import 'package:calorie_lens_ai_app/core/widgets/device_size/device_size.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/splash/splash_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/splash/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SplashPageMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DeviceSize.init(context);

      // İlk açılışta BlocProviderSetUp zaten initializeApp()'i çağırıyor.
      // Ancak e-posta doğrulama gibi senaryolarda SplashPage tekrar route'lanır;
      // cubit eski bir terminal state'de (ör. SplashNavigateToEmailVerification)
      // kalır ve listener bir daha ateşlenmez. Bu durumu tespit edip
      // initializeApp()'i yeniden tetikliyoruz.
      final cubit = context.read<SplashCubit>();
      final state = cubit.state;
      if (state is! SplashInitial && state is! SplashLoading) {
        cubit.initializeApp();
      }
    });
  }
}
