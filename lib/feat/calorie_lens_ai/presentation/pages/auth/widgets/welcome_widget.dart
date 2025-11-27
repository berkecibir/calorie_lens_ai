import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(AppTexts.welcomeText,
        style: Theme.of(context).textTheme.headlineSmall);
  }
}
