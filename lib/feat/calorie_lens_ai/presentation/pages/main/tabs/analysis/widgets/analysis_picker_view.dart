import 'package:calorie_lens_ai_app/core/utils/const/analysis_page_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/analysis_picker_header.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis/widgets/subwidgets/gallery_button.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/buttons/wizard_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AnalysisPickerView extends StatelessWidget {
  const AnalysisPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FoodAnalysisCubit>();

    return Padding(
      padding: DevicePadding.xlarge.all,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AnalysisPickerHeader(),
                const Spacer(),
                WizardContinueButton(
                  onPressed: () => cubit.pickAndAnalyze(ImageSource.camera),
                  text: AnalysisPageTexts.cameraButton,
                ),
                DeviceSpacing.medium.height,
                GalleryButton(
                  onPressed: () => cubit.pickAndAnalyze(ImageSource.gallery),
                ),
                DeviceSpacing.large.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
