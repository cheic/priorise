import 'package:isar/isar.dart';
import '../../core/models/weekly_review_model.dart';
import '../../core/services/database_service.dart';
import '../../domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final DatabaseService _db;
  ReviewRepositoryImpl(this._db);

  @override
  Future<List<WeeklyReview>> getAllReviews() => _db.isar.weeklyReviews.where().findAll();

  @override
  Future<WeeklyReview?> getReviewByDate(DateTime date) {
    return _db.isar.weeklyReviews.filter().weekStartEqualTo(date).findFirst();
  }

  @override
  Future<void> saveReview(WeeklyReview review) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.weeklyReviews.put(review);
    });
  }
}
