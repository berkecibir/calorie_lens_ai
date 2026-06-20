import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/data/models/meal_log/meal_log_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MealLogRemoteDataSource {
  Future<void> saveMealLog(MealLogModel mealLog);
  Future<List<MealLogModel>> getDailyMealLogs(String userId, DateTime date);
}

class MealLogRemoteDataSourceImpl implements MealLogRemoteDataSource {
  final FirebaseFirestore firestore;

  MealLogRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> saveMealLog(MealLogModel mealLog) async {
    await firestore
        .collection('meal_logs')
        .doc(mealLog.id)
        .set(mealLog.toJson());
  }

  @override
  Future<List<MealLogModel>> getDailyMealLogs(String userId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await firestore
        .collection('meal_logs')
        .where('userId', isEqualTo: userId)
        .where('dateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('dateTime', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

    return snapshot.docs.map((doc) => MealLogModel.fromJson(doc.data())).toList();
  }
}
