import 'package:isar/isar.dart';
import '../../core/models/mission_model.dart';
import '../../core/services/database_service.dart';
import '../../domain/repositories/mission_repository.dart';

class MissionRepositoryImpl implements MissionRepository {
  final DatabaseService _db;
  MissionRepositoryImpl(this._db);

  @override
  Future<Mission?> getMission() => _db.isar.missions.where().findFirst();

  @override
  Future<void> saveMission(Mission mission) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.missions.put(mission);
    });
  }
}
