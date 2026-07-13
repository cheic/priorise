import 'package:flutter_bloc/flutter_bloc.dart';

class MockAiState {
  final bool isEnabled;
  final String apiKey;
  const MockAiState({this.isEnabled = false, this.apiKey = ''});
  MockAiState copyWith({bool? isEnabled, String? apiKey}) {
    return MockAiState(
      isEnabled: isEnabled ?? this.isEnabled,
      apiKey: apiKey ?? this.apiKey,
    );
  }
}

class MockAiCubit extends Cubit<MockAiState> {
  MockAiCubit() : super(const MockAiState());
  void toggleAi(bool val) => emit(state.copyWith(isEnabled: val));
  void setApiKey(String key) => emit(state.copyWith(apiKey: key));
}
