import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/mixin/home_tab_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/daily_calorie_card.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/home_greeting_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/home_quick_actions.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/cards/nutrient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with HomeTabMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      // Performans: Sadece Loading, Loaded veya Error durumlarında rebuild et.
      // Eşitlik kontrolü Equatable sayesinde otomatik yapılır.
      buildWhen: (previous, current) {
        return current is MainLoading ||
            current is MainLoaded ||
            current is MainError;
      },
      builder: (context, state) {
        if (state is MainLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MainError) {
          return Center(child: Text(state.message));
        } else if (state is MainLoaded) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Karşılama ---
                  HomeGreetingSection(userName: state.userName),
                  const SizedBox(height: AppSizes.s24),

                  // --- Günlük Kalori ---
                  DailyCalorieCard(
                    dailyGoal: state.dailyCalorieGoal,
                    consumed: state.consumedCalories,
                  ),
                  const SizedBox(height: AppSizes.s16),

                  // --- Makro Özet ---
                  _buildMacroRow(state),
                  const SizedBox(height: AppSizes.s24),

                  // --- Günlük İçgörü (Insight) ---
                  if (state.insightMessage.isNotEmpty) ...[
                    _buildInsightCard(context, state.insightMessage),
                    const SizedBox(height: AppSizes.s24),
                  ],

                  // --- Hızlı Erişim ---
                  const HomeQuickActions(),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInsightCard(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSizes.s12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insights_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroRow(MainLoaded state) {
    return Row(
      children: [
        Expanded(
          child: NutrientCard(
            label: HomePageTexts.proteinLabel,
            current: 0, // TODO: state.consumedProtein
            target: state.proteinTarget,
            color: const Color(0xFF42A5F5),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: NutrientCard(
            label: HomePageTexts.carbLabel,
            current: 0, // TODO: state.consumedCarb
            target: state.carbTarget,
            color: const Color(0xFFFFA726),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: NutrientCard(
            label: HomePageTexts.fatLabel,
            current: 0, // TODO: state.consumedFat
            target: state.fatTarget,
            color: const Color(0xFFEF5350),
          ),
        ),
      ],
    );
  }
}
