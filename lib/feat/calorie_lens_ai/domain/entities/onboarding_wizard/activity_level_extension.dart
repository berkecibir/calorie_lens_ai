import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/domain/entities/onboarding_wizard/user_profile_entity.dart';
import 'package:flutter/material.dart';

extension ActivityLevelExtension on ActivityLevel {
  String get title {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Hareketsiz';
      case ActivityLevel.lightlyActive:
        return 'Az Hareketli';
      case ActivityLevel.moderate:
        return 'Orta Hareketli';
      case ActivityLevel.active:
        return 'Çok Hareketli';
      case ActivityLevel.veryActive:
        return 'Aşırı Hareketli';
    }
  }

  String get description {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Masa başı iş, az veya hiç egzersiz yok.';
      case ActivityLevel.lightlyActive:
        return 'Hafif egzersiz/spor (haftada 1-3 gün).';
      case ActivityLevel.moderate:
        return 'Orta düzey egzersiz/spor (haftada 3-5 gün).';
      case ActivityLevel.active:
        return 'Ağır egzersiz/spor (haftada 6-7 gün).';
      case ActivityLevel.veryActive:
        return 'Çok ağır egzersiz, fiziksel iş veya günde 2 antrenman.';
    }
  }

  IconData get icon {
    switch (this) {
      case ActivityLevel.sedentary:
        return Icons.chair_outlined;
      case ActivityLevel.lightlyActive:
        return Icons.directions_walk;
      case ActivityLevel.moderate:
        return Icons.fitness_center;
      case ActivityLevel.active:
        return Icons.directions_run;
      case ActivityLevel.veryActive:
        return Icons.local_fire_department;
    }
  }
}
