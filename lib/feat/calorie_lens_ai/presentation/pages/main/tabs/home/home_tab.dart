import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/main/main_state.dart';
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

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    // Sayfa ilk açıldığında veriyi yükle
    // (Eğer MainCubit lazy:false ise buna gerek kalmayabilir ama garanti olsun)
    final cubit = context.read<MainCubit>();
    if (cubit.state is MainInitial) {
      cubit.loadMainScreenData();
    }
  }

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

  Widget _buildMacroRow(MainLoaded state) {
    return Row(
      children: [
        Expanded(
          child: NutrientCard(
            label: 'Protein',
            current: 0, // TODO: state.consumedProtein
            target: state.proteinTarget,
            color: const Color(0xFF42A5F5),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: NutrientCard(
            label: 'Karbonhidrat',
            current: 0, // TODO: state.consumedCarb
            target: state.carbTarget,
            color: const Color(0xFFFFA726),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: NutrientCard(
            label: 'Yağ',
            current: 0, // TODO: state.consumedFat
            target: state.fatTarget,
            color: const Color(0xFFEF5350),
          ),
        ),
      ],
    );
  }
}
