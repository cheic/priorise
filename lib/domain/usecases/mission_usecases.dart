import '../../core/models/mission_model.dart';
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
    final existingMission = await repository.getMission();
    final mission = existingMission ?? Mission();
    mission.statement = statement;
    mission.lastEditedAt = DateTime.now();
    await repository.saveMission(mission);
  }
}
