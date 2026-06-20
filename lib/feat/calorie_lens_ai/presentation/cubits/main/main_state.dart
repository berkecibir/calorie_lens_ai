import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();
  @override
  List<Object?> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final String userName;
  final double dailyCalorieGoal;
  final int proteinTarget;
  final int carbTarget;
  final int fatTarget;
  final int consumedCalories;
  final int consumedProtein;
  final int consumedCarbs;
  final int consumedFat;
  final List<MealLogEntity> todayMeals;
  final String insightMessage;

  const MainLoaded({
    required this.userName,
    required this.dailyCalorieGoal,
    required this.proteinTarget,
    required this.carbTarget,
    required this.fatTarget,
    this.consumedCalories = 0,
    this.consumedProtein = 0,
    this.consumedCarbs = 0,
    this.consumedFat = 0,
    this.todayMeals = const [],
    this.insightMessage = '',
  });

  @override
  List<Object?> get props => [
        userName,
        dailyCalorieGoal,
        proteinTarget,
        carbTarget,
        fatTarget,
        consumedCalories,
        consumedProtein,
        consumedCarbs,
        consumedFat,
        todayMeals,
        insightMessage,
      ];
}

class MainError extends MainState {
  final String message;

  const MainError({required this.message});

  @override
  List<Object?> get props => [message];
}
