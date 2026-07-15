import '../../core/models/weekly_review_model.dart';
import '../repositories/review_repository.dart';

class GetAllReviewsUseCase {
  final ReviewRepository repository;
  GetAllReviewsUseCase(this.repository);
  Future<List<WeeklyReview>> call() => repository.getAllReviews();
}

class GetReviewByDateUseCase {
  final ReviewRepository repository;
  GetReviewByDateUseCase(this.repository);
  Future<WeeklyReview?> call(DateTime date) => repository.getReviewByDate(date);
}

class SaveReviewUseCase {
  final ReviewRepository repository;
  SaveReviewUseCase(this.repository);
  Future<void> call(WeeklyReview review) => repository.saveReview(review);
}
