import '../../../core/models/weekly_plan_model.dart';

abstract class PlanRepository {
  Future<WeeklyPlan?> getCurrentPlan();
  Future<void> savePlan(WeeklyPlan plan);
}
