import 'dart:io';

import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/food_analysis/analyze_food.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/cubits/food_analysis/food_analysis_state.dart';
import 'package:calorie_lens_ai_app/core/usecases/usecases.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/food_analysis/food_analysis_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/meal_log/meal_log_entity.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/auth/get_current_user.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/usecases/meal_log/save_meal_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FoodAnalysisCubit extends Cubit<FoodAnalysisState> {
  final AnalyzeFood analyzeFood;
  final SaveMealLog saveMealLog;
  final GetCurrentUser getCurrentUser;

  final ImagePicker _picker = ImagePicker();

  FoodAnalysisCubit({
    required this.analyzeFood,
    required this.saveMealLog,
    required this.getCurrentUser,
  }) : super(FoodAnalysisInitial());

  Future<void> pickAndAnalyze(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
          source: source, imageQuality: 85, maxWidth: 1024);
      if (picked == null) return; // user iptal ederse
      emit(FoodAnalysisLoading());
      final imageFile = File(picked.path);
      final result = await analyzeFood(AnalyzeFoodParams(imageFile: imageFile));
      result.fold(
        (failure) => emit(FoodAnalysisError(message: failure.toString())),
        (entity) => emit(FoodAnalysisSuccess(result: entity, image: imageFile)),
      );
    } catch (e) {
      emit(FoodAnalysisError(message: 'Bir hata oluştu: $e'));
    }
  }

  Future<void> saveResultToLog(FoodAnalysisEntity result) async {
    try {
      final userResult = await getCurrentUser(NoParams());
      final user = userResult.fold((l) => null, (r) => r);
      if (user == null) {
        emit(FoodAnalysisError(message: 'Oturum açmış kullanıcı bulunamadı'));
        return;
      }

      final mealLog = MealLogEntity(
        id: const Uuid().v4(),
        userId: user.uid,
        foodName: result.foodName,
        calories: result.calories,
        proteinG: result.proteinG,
        carbsG: result.carbsG,
        fatG: result.fatG,
        dateTime: DateTime.now(),
      );

      final saveResult = await saveMealLog(mealLog);
      saveResult.fold(
        (failure) =>
            emit(FoodAnalysisError(message: 'Kaydedilemedi: $failure')),
        (_) {
          // Başarılı kayıttan sonra resetle veya bir 'saved' state'i gönder
          // Şimdilik Initial'a dönüyoruz ki kullanıcı yeni bir şey alabilsin
          // (Veya Success içinde bir flag tutulabilir snackbar göstermek için)
          emit(FoodAnalysisInitial());
        },
      );
    } catch (e) {
      emit(FoodAnalysisError(message: 'Kayıt sırasında hata: $e'));
    }
  }

  void reset() => emit(FoodAnalysisInitial());
}
