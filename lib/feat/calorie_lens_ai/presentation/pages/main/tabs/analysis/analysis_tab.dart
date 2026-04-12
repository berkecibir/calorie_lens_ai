import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/analysis_error_view.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/analysis_loading_view.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/analysis_picker_view.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/analysis_result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalysisTab extends StatelessWidget {
  const AnalysisTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodAnalysisCubit, FoodAnalysisState>(
      // Sadece state tipi değiştiğinde rebuild et — gereksiz render yok
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        // Gerekirse buraya snackbar/navigation eklenebilir
      },
      builder: (context, state) {
        return switch (state) {
          FoodAnalysisInitial() => const AnalysisPickerView(),
          FoodAnalysisLoading() => const AnalysisLoadingView(),
          FoodAnalysisSuccess() => AnalysisResultView(state: state),
          FoodAnalysisError() => AnalysisErrorView(state: state),
          _ => const AnalysisPickerView(),
        };
      },
    );
  }
}
