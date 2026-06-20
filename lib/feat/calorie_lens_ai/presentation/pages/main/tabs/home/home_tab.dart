import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/utils/const/home_page_texts.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_state.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/mixin/home_tab_mixin.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/daily_calorie_card.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/home_greeting_section.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/home_quick_actions.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/subwidgets/home_insight_card.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/subwidgets/home_macro_row.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home/widgets/subwidgets/today_meals_list.dart';
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
                  HomeGreetingSection(userName: state.userName),
                  const SizedBox(height: AppSizes.s24),
                  DailyCalorieCard(
                    dailyGoal: state.dailyCalorieGoal,
                    consumed: state.consumedCalories,
                  ),
                  const SizedBox(height: AppSizes.s16),
                  HomeMacroRow(
                    consumedProtein: state.consumedProtein,
                    proteinTarget: state.proteinTarget,
                    consumedCarbs: state.consumedCarbs,
                    carbTarget: state.carbTarget,
                    consumedFat: state.consumedFat,
                    fatTarget: state.fatTarget,
                  ),
                  const SizedBox(height: AppSizes.s24),
                  if (state.insightMessage.isNotEmpty) ...[
                    HomeInsightCard(message: state.insightMessage),
                    const SizedBox(height: AppSizes.s24),
                  ],
                  const HomeQuickActions(),
                  const SizedBox(height: AppSizes.s24),
                  Text(
                    HomePageTexts.todayMealsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppSizes.s12),
                  TodayMealsList(meals: state.todayMeals),
                  const SizedBox(height: AppSizes.s32),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
