import 'package:flutter_bloc/flutter_bloc.dart';

class ShellCubit extends Cubit<int> {
  ShellCubit({int initialIndex = 0}) : super(initialIndex);

  void selectTab(int index) => emit(index);
}
