import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/bottom_nav/bottom_nav_cubit.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/analysis_tab.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/home_tab.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/profile_tab.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/main/tabs/tracker_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  static const String id = 'main_page';
  const MainPage({super.key});

  static const List<Widget> _tabs = [
    HomeTab(),
    AnalysisTab(),
    TrackerTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: _tabs,
          ),
          bottomNavigationBar: _buildBottomNavBar(context, currentIndex),
        );
      },
    );
  }

  Widget _buildBottomNavBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt_outlined),
          activeIcon: Icon(Icons.camera_alt_rounded),
          label: 'Analiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart_rounded),
          label: 'Takip',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profil',
        ),
      ],
    );
  }
}
