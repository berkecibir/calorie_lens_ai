import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the currently selected bottom navigation tab index.
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  /// Changes the active tab to [index].
  void changeTab(int index) {
    if (index != state) emit(index);
  }
}
