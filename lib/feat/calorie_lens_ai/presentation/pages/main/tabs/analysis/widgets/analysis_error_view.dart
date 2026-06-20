import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/error_icon.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/error_message_text.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/error_title_text.dart';
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
          const ErrorIcon(),
          DeviceSpacing.large.height,
          const ErrorTitleText(),
          DeviceSpacing.small.height,
          ErrorMessageText(message: state.message),
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
