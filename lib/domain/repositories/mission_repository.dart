import '../../../core/models/mission_model.dart';

abstract class MissionRepository {
  Future<Mission?> getMission();
  Future<void> saveMission(Mission mission);
}
