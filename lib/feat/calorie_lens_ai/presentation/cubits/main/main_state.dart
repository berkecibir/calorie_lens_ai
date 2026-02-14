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

  const MainLoaded(
      {required this.userName,
      required this.dailyCalorieGoal,
      required this.proteinTarget,
      required this.carbTarget,
      required this.fatTarget,
      this.consumedCalories = 0});

  @override
  List<Object?> get props => [
        userName,
        dailyCalorieGoal,
        proteinTarget,
        carbTarget,
        fatTarget,
        consumedCalories,
      ];
}

class MainError extends MainState {
  final String message;

  const MainError({required this.message});

  @override
  List<Object?> get props => [message];
}
