// onboarding_cubit.dart — état de l'onboarding.
// Responsabilité unique : progression de page + transition vers Today.
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/secure_storage_service.dart';

enum OnboardingStatus { inProgress, done }

class OnboardingState {
  const OnboardingState({
    this.currentPage = 0,
    this.status = OnboardingStatus.inProgress,
  });

  final int currentPage;
  final OnboardingStatus status;

  static const int totalPages = 4;

  bool get isLastPage => currentPage == totalPages - 1;

  OnboardingState copyWith({int? currentPage, OnboardingStatus? status}) =>
      OnboardingState(
        currentPage: currentPage ?? this.currentPage,
        status: status ?? this.status,
      );
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void goToPage(int index) {
    if (index < 0 || index >= OnboardingState.totalPages) return;
    emit(state.copyWith(currentPage: index));
  }

  void nextPage() {
    if (state.isLastPage) {
      _finish();
    } else {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void skip() => _finish();

  Future<void> _finish() async {
    // Persiste le flag avant de signaler done — évite une boucle de splash.
    await getIt<SecureStorageService>().setFirstLaunchDone();
    emit(state.copyWith(status: OnboardingStatus.done));
  }
}
