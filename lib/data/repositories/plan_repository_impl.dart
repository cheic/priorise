import 'package:isar/isar.dart';
import '../../core/models/weekly_plan_model.dart';
import '../../core/services/database_service.dart';
import '../../domain/repositories/plan_repository.dart';

class PlanRepositoryImpl implements PlanRepository {
  final DatabaseService _db;
  PlanRepositoryImpl(this._db);

  @override
  Future<WeeklyPlan?> getCurrentPlan() => _db.isar.weeklyPlans.where().sortByWeekStartDesc().findFirst();

  @override
  Future<void> savePlan(WeeklyPlan plan) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.weeklyPlans.put(plan);
    });
  }
}
