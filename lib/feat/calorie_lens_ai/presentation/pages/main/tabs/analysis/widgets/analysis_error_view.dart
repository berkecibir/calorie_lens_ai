import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalysisErrorView extends StatelessWidget {
  final FoodAnalysisError state;

  const AnalysisErrorView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DevicePadding.xlarge.all,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Statik bölüm — state değişmez, rebuild gereksiz
          const _ErrorIcon(),
          DeviceSpacing.large.height,
          const _ErrorTitleText(),
          DeviceSpacing.small.height,

          // Dinamik bölüm — hata mesajı state'e bağlı
          _ErrorMessageText(message: state.message),
          DeviceSpacing.xxlarge.height,

          WizardContinueButton(
            onPressed: context.read<FoodAnalysisCubit>().reset,
            text: AnalysisPageTexts.retryButton,
          ),
        ],
      ),
    );
  }
}

class _ErrorIcon extends StatelessWidget {
  const _ErrorIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error_outline_rounded,
      size: AppSizes.s64,
      color: Theme.of(context).colorScheme.error,
    );
  }
}

class _ErrorTitleText extends StatelessWidget {
  const _ErrorTitleText();

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

class _ErrorMessageText extends StatelessWidget {
  final String message;

  const _ErrorMessageText({required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
    );
  }
}
