import '../../../core/models/weekly_review_model.dart';

abstract class ReviewRepository {
  Future<List<WeeklyReview>> getAllReviews();
  Future<WeeklyReview?> getReviewByDate(DateTime date);
  Future<void> saveReview(WeeklyReview review);
}
