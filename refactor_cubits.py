import os
import re

usecases_dir = 'lib/domain/usecases'
os.makedirs(usecases_dir, exist_ok=True)

# 1. TASK USECASES
with open(f'{usecases_dir}/task_usecases.dart', 'w') as f:
    f.write('''import '../../core/models/task_model.dart';
import '../repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;
  GetAllTasksUseCase(this.repository);
  Future<List<Task>> call() => repository.getAllTasks();
}

class GetTodayTasksUseCase {
  final TaskRepository repository;
  GetTodayTasksUseCase(this.repository);
  Future<List<Task>> call() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return repository.getTasksForDate(startOfDay, endOfDay);
  }
}

class GetPendingTasksUseCase {
  final TaskRepository repository;
  GetPendingTasksUseCase(this.repository);
  Future<List<Task>> call() => repository.getPendingTasks();
}

class ToggleTaskUseCase {
  final TaskRepository repository;
  ToggleTaskUseCase(this.repository);
  Future<void> call(int taskId) async {
    final task = await repository.getTaskById(taskId);
    if (task == null) return;
    task.done = !task.done;
    task.doneAt = task.done ? DateTime.now() : null;
    await repository.saveTask(task);
  }
}

class AddTaskUseCase {
  final TaskRepository repository;
  AddTaskUseCase(this.repository);
  Future<void> call(String title, int roleId, {bool important = false, bool urgent = false}) async {
    final task = Task()
      ..title = title
      ..roleId = roleId
      ..important = important
      ..urgent = urgent
      ..weekStart = DateTime.now();
    await repository.saveTask(task);
  }
}

class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);
  Future<void> call(int taskId, String title, int roleId, {bool important = false, bool urgent = false}) async {
    final task = await repository.getTaskById(taskId);
    if (task == null) return;
    task.title = title;
    task.roleId = roleId;
    task.important = important;
    task.urgent = urgent;
    await repository.saveTask(task);
  }
}

class DeleteTaskUseCase {
  final TaskRepository repository;
  DeleteTaskUseCase(this.repository);
  Future<void> call(int taskId) => repository.deleteTask(taskId);
}

class WatchTasksUseCase {
  final TaskRepository repository;
  WatchTasksUseCase(this.repository);
  Stream<void> call() => repository.watchTasks();
}
''')

# 2. ROLE USECASES
with open(f'{usecases_dir}/role_usecases.dart', 'w') as f:
    f.write('''import '../../core/models/role_model.dart';
import '../repositories/role_repository.dart';

class GetAllRolesUseCase {
  final RoleRepository repository;
  GetAllRolesUseCase(this.repository);
  Future<List<LifeRole>> call() => repository.getAllRoles();
}

class AddRoleUseCase {
  final RoleRepository repository;
  AddRoleUseCase(this.repository);
  Future<void> call(String name, String colorString) async {
    final role = LifeRole()
      ..name = name
      ..colorString = colorString;
    await repository.saveRole(role);
  }
}

class UpdateRoleUseCase {
  final RoleRepository repository;
  UpdateRoleUseCase(this.repository);
  Future<void> call(int id, String name, String colorString) async {
    final role = LifeRole()
      ..id = id
      ..name = name
      ..colorString = colorString;
    await repository.saveRole(role);
  }
}

class DeleteRoleUseCase {
  final RoleRepository repository;
  DeleteRoleUseCase(this.repository);
  Future<void> call(int id) => repository.deleteRole(id);
}
''')

# 3. MISSION USECASES
with open(f'{usecases_dir}/mission_usecases.dart', 'w') as f:
    f.write('''import '../../core/models/mission_model.dart';
import '../repositories/mission_repository.dart';

class GetMissionUseCase {
  final MissionRepository repository;
  GetMissionUseCase(this.repository);
  Future<Mission?> call() => repository.getMission();
}

class SaveMissionUseCase {
  final MissionRepository repository;
  SaveMissionUseCase(this.repository);
  Future<void> call(String statement, int revisionIntervalMonths) async {
    final mission = Mission()
      ..personalStatement = statement
      ..revisionIntervalMonths = revisionIntervalMonths
      ..lastRevision = DateTime.now();
    await repository.saveMission(mission);
  }
}
''')

# 4. PLAN USECASES
with open(f'{usecases_dir}/plan_usecases.dart', 'w') as f:
    f.write('''import '../../core/models/weekly_plan_model.dart';
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
''')

# 5. REVIEW USECASES
with open(f'{usecases_dir}/review_usecases.dart', 'w') as f:
    f.write('''import '../../core/models/weekly_review_model.dart';
import '../repositories/review_repository.dart';

class GetAllReviewsUseCase {
  final ReviewRepository repository;
  GetAllReviewsUseCase(this.repository);
  Future<List<WeeklyReview>> call() => repository.getAllReviews();
}

class GetReviewByDateUseCase {
  final ReviewRepository repository;
  GetReviewByDateUseCase(this.repository);
  Future<WeeklyReview?> call(DateTime date) => repository.getReviewByDate(date);
}

class SaveReviewUseCase {
  final ReviewRepository repository;
  SaveReviewUseCase(this.repository);
  Future<void> call(WeeklyReview review) => repository.saveReview(review);
}
''')

# 6. SETTINGS USECASES
with open(f'{usecases_dir}/settings_usecases.dart', 'w') as f:
    f.write('''import '../../core/models/app_settings_model.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;
  GetSettingsUseCase(this.repository);
  Future<AppSettings> call() => repository.getSettings();
}

class SaveSettingsUseCase {
  final SettingsRepository repository;
  SaveSettingsUseCase(this.repository);
  Future<void> call(AppSettings settings) => repository.saveSettings(settings);
}
''')

