import '../../core/models/weekly_plan_model.dart';
import '../repositories/plan_repository.dart';

class GetCurrentPlanUseCase {
  final PlanRepository repository;
  GetCurrentPlanUseCase(this.repository);
  Future<WeeklyPlan?> call() => repository.getCurrentPlan();
}

class SavePlanUseCase {
  final PlanRepository repository;
  SavePlanUseCase(this.repository);
  Future<void> call(WeeklyPlan plan) => repository.savePlan(plan);
}
