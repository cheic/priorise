import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/services/database_service.dart';
import '../../../core/models/mission_model.dart' as isar;
import '../../../core/di/injection.dart';

sealed class MissionState {}

class MissionLoading extends MissionState {}

class MissionLoaded extends MissionState {
  MissionLoaded({
    required this.statement,
    required this.lastEditedAt,
  });

  final String statement;
  final DateTime lastEditedAt;
}

class MissionError extends MissionState {
  final String message;
  MissionError(this.message);
}

class MissionCubit extends Cubit<MissionState> {
  MissionCubit() : super(MissionLoading()) {
    _db = getIt<DatabaseService>();
    _load();
  }

  late final DatabaseService _db;
  late int _missionId;

  Future<void> _load() async {
    final isarDb = _db.isar;
    final mission = await isarDb.missions.where().findFirst();

    if (mission == null) {
      final newMission = isar.Mission()
        ..statement = "Je veux être présent avant d'être efficace, curieux avant d'être certain, et bâtir des choses qui rendent la vie des autres plus simple — sans jamais leur voler leur attention."
        ..lastEditedAt = DateTime.now();

      await isarDb.writeTxn(() async {
        _missionId = await isarDb.missions.put(newMission);
      });

      emit(MissionLoaded(
        statement: newMission.statement,
        lastEditedAt: newMission.lastEditedAt,
      ));
    } else {
      _missionId = mission.id;
      emit(MissionLoaded(
        statement: mission.statement,
        lastEditedAt: mission.lastEditedAt,
      ));
    }
  }

  Future<void> updateMission(String newStatement) async {
    final currentState = state;
    if (currentState is! MissionLoaded) return;

    final isarDb = _db.isar;
    await isarDb.writeTxn(() async {
      final mission = await isarDb.missions.get(_missionId);
      if (mission != null) {
        mission.statement = newStatement;
        mission.lastEditedAt = DateTime.now();
        await isarDb.missions.put(mission);
      }
    });

    await _load();
  }
}
