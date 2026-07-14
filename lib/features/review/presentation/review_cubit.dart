import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
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
  final Isar isar;
  DateTime? _currentWeekStart;
  StreamSubscription<void>? _rolesSubscription;
  StreamSubscription<void>? _tasksSubscription;

  ReviewCubit(this.isar) : super(const ReviewState()) {
    _rolesSubscription = isar.lifeRoles.watchLazy().listen((_) {
      if (_currentWeekStart != null) loadReview(_currentWeekStart!);
    });
    _tasksSubscription = isar.tasks.watchLazy().listen((_) {
      if (_currentWeekStart != null) loadReview(_currentWeekStart!);
    });
  }

  @override
  Future<void> close() {
    _rolesSubscription?.cancel();
    _tasksSubscription?.cancel();
    return super.close();
  }

  Future<void> loadReview(DateTime weekStart) async {
    _currentWeekStart = weekStart;
    // We don't want to show loading state every time a task changes (too much flickering)
    if (state.roles.isEmpty && state.tasksForWeek.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    
    // Normalize to start of week (e.g. Monday 00:00)
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    
    final review = await isar.weeklyReviews.where().weekStartEqualTo(start).findFirst();
    final roles = await isar.lifeRoles.where().findAll();
    final tasksForWeek = await isar.tasks.where().filter().weekStartEqualTo(start).findAll();
    
    emit(state.copyWith(
      review: review,
      roles: roles,
      tasksForWeek: tasksForWeek,
      isLoading: false,
    ));
  }

  Future<void> updateAnswers(String whatWorked, String whatSlipped) async {
    final currentReview = state.review;
    if (currentReview == null) return;

    currentReview.whatWorked = whatWorked;
    currentReview.whatSlipped = whatSlipped;

    await isar.writeTxn(() async {
      await isar.weeklyReviews.put(currentReview);
    });

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
        await isar.writeTxn(() async {
          await isar.weeklyReviews.put(currentReview);
        });
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
