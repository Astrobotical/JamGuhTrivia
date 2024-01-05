import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'difficulty_state.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit() : super(const DifficultyState());

  void selectDifficulty(Difficulty difficulty) {
    emit(DifficultyState(selectedDifficulty: difficulty));
  }
}
