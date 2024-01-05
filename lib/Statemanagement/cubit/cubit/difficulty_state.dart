part of 'difficulty_cubit.dart';

enum Difficulty { beginner, intermediate, advanced }

@immutable
class DifficultyState {
  final Difficulty selectedDifficulty;

  const DifficultyState({this.selectedDifficulty = Difficulty.beginner});
}

