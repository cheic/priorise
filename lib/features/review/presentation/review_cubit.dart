import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../core/models/weekly_review_model.dart';
import '../../../core/models/role_model.dart';
import '../../../core/models/task_model.dart';

class ReviewState {
  final WeeklyReview? review;
  final List<LifeRole> roles;
  final List<Task> tasksForWeek;
  final bool isLoading;

  const ReviewState({
    this.review,
    this.roles = const [],
    this.tasksForWeek = const [],
    this.isLoading = true,
  });

  ReviewState copyWith({
    WeeklyReview? review,
    List<LifeRole>? roles,
    List<Task>? tasksForWeek,
    bool? isLoading,
  }) {
    return ReviewState(
      review: review ?? this.review,
      roles: roles ?? this.roles,
      tasksForWeek: tasksForWeek ?? this.tasksForWeek,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ReviewCubit extends Cubit<ReviewState> {
  final Isar isar;

  ReviewCubit(this.isar) : super(const ReviewState());

  Future<void> loadReview(DateTime weekStart) async {
    emit(state.copyWith(isLoading: true));
    
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
}
