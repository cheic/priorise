import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/review_usecases.dart';
import '../../../domain/usecases/role_usecases.dart';
import '../../../domain/usecases/task_usecases.dart';
import '../../../core/models/weekly_review_model.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/task_model.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/ai_service.dart';

class ReviewState {
  final WeeklyReview? review;
  final List<LifeRole> roles;
  final List<Task> tasksForWeek;
  final bool isLoading;
  final bool isSynthesizing;

  const ReviewState({
    this.review,
    this.roles = const [],
    this.tasksForWeek = const [],
    this.isLoading = true,
    this.isSynthesizing = false,
  });

  ReviewState copyWith({
    WeeklyReview? review,
    List<LifeRole>? roles,
    List<Task>? tasksForWeek,
    bool? isLoading,
    bool? isSynthesizing,
  }) {
    return ReviewState(
      review: review ?? this.review,
      roles: roles ?? this.roles,
      tasksForWeek: tasksForWeek ?? this.tasksForWeek,
      isLoading: isLoading ?? this.isLoading,
      isSynthesizing: isSynthesizing ?? this.isSynthesizing,
    );
  }
}

class ReviewCubit extends Cubit<ReviewState> {
  final GetReviewByDateUseCase getReviewByDate;
  final SaveReviewUseCase saveReviewUseCase;
  final GetAllRolesUseCase getAllRoles;
  final GetAllTasksUseCase getTasks; 

  

  ReviewCubit({
    required this.getReviewByDate,
    required this.saveReviewUseCase,
    required this.getAllRoles,
    required this.getTasks,
  }) : super(const ReviewState());

  Future<void> loadReview(DateTime weekStart) async {
    
    if (state.roles.isEmpty && state.tasksForWeek.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    
    final review = await getReviewByDate(start);
    final roles = await getAllRoles();
    
    // We should probably get tasks for the specific week, but let's just get all for now,
    // or add a usecase method if needed. For now, since Isar is abstracted, 
    // we assume getTasks gets what we need, or we filter. Let's just use getTasks() and filter it manually here if we must,
    // but a proper UseCase 'GetTasksForWeekUseCase' would be better.
    // Let's assume GetPendingTasks gets all undone tasks. But weekly review needs ALL tasks for the week.
    // Let's modify the use case to provide GetTasksForWeekUseCase.
    final allTasks = await getTasks(); 
    final tasksForWeek = allTasks.where((t) => t.weekStart.year == start.year && t.weekStart.month == start.month && t.weekStart.day == start.day).toList();
    
    emit(state.copyWith(
      review: review,
      roles: roles,
      tasksForWeek: tasksForWeek,
      isLoading: false,
    ));
  }

  Future<void> refresh() async {
    final review = state.review;
    if (review != null) {
      await loadReview(review.weekStart);
    } else {
      final now = DateTime.now();
      final monday = now.subtract(Duration(days: now.weekday - 1));
      await loadReview(monday);
    }
  }

  Future<void> updateAnswers(String whatWorked, String whatSlipped) async {
    final currentReview = state.review;
    if (currentReview == null) return;

    currentReview.whatWorked = whatWorked;
    currentReview.whatSlipped = whatSlipped;

    await saveReviewUseCase(currentReview);
    emit(state.copyWith(review: currentReview));
  }

  Future<void> synthesizeWithAI({
    required String provider,
    required String apiKey,
    required Function(String) onError,
    required Function() onSuccess,
  }) async {
    if (state.isSynthesizing) return;
    
    emit(state.copyWith(isSynthesizing: true));

    try {
      final aiService = getIt<AiService>();
      final result = await aiService.synthesizeReview(
        provider: provider,
        apiKey: apiKey,
        roles: state.roles,
        tasks: state.tasksForWeek,
        currentWorked: state.review?.whatWorked ?? "",
        currentSlipped: state.review?.whatSlipped ?? "",
      );

      final currentReview = state.review;
      if (currentReview != null) {
        currentReview.whatWorked = result['whatWorked'] ?? "L'IA n'a pas pu synthétiser ce point.";
        currentReview.whatSlipped = result['whatSlipped'] ?? "L'IA n'a pas pu synthétiser ce point.";
        await saveReviewUseCase(currentReview);
        emit(state.copyWith(review: currentReview));
      }
      
      onSuccess();
    } catch (e) {
      onError(e.toString().replaceAll("Exception: ", ""));
    } finally {
      emit(state.copyWith(isSynthesizing: false));
    }
  }
}
