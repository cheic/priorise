import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/mission_usecases.dart';

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
  final GetMissionUseCase getMissionUseCase;
  final SaveMissionUseCase saveMissionUseCase;

  MissionCubit({
    required this.getMissionUseCase,
    required this.saveMissionUseCase,
  }) : super(MissionLoading()) {
    loadMission();
  }

  Future<void> loadMission() async {
    emit(MissionLoading());
    try {
      final mission = await getMissionUseCase();
      if (mission != null) {
        emit(MissionLoaded(
          statement: mission.statement,
          lastEditedAt: mission.lastEditedAt,
        ));
      } else {
        // default mission?
        await updateMission("");
      }
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> updateMission(String newStatement) async {
    final currentState = state;
    if (currentState is MissionLoaded) {
      await saveMissionUseCase(newStatement, 6);
    } else {
      await saveMissionUseCase(newStatement, 6);
    }
    loadMission();
  }
}
