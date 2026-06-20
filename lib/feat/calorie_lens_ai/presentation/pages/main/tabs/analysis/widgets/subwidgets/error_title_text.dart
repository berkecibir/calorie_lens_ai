import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:flutter/material.dart';

class ErrorTitleText extends StatelessWidget {
  const ErrorTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AnalysisPageTexts.errorTitle,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
