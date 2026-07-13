import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task_model.dart';
import '../models/role_model.dart';
import '../models/mission_model.dart';
import '../models/app_settings_model.dart';
import '../models/weekly_plan_model.dart';
import '../models/weekly_review_model.dart';
import '../models/ai_provider_model.dart';

class DatabaseService {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        TaskSchema,
        LifeRoleSchema,
        MissionSchema,
        AppSettingsSchema,
        WeeklyPlanSchema,
        WeeklyReviewSchema,
        AiProviderConfigSchema,
      ],
      directory: dir.path,
    );
  }
}
