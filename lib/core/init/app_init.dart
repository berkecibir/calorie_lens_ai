import 'package:calorie_lens_ai_app/core/widgets/device_size/device_size.dart';
import 'package:calorie_lens_ai_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppInit {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static void initDeviceSize(BuildContext context) {
    DeviceSize.init(context);
  }
}
