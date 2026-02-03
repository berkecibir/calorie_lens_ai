import 'package:calorie_lens_ai_app/core/widgets/device_size/device_size.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/splash/page/splash_page.dart';
import 'package:flutter/material.dart';

mixin SplashPageMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DeviceSize.init(context);
    });
  }
}
