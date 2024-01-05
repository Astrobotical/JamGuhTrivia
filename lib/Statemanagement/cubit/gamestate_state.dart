part of 'gamestate_cubit.dart';

@immutable
sealed class GamestateState {

}

final class GamestateInitial extends GamestateState {}

final class GamestateRadioChanged extends GamestateState {}

final class GamestateRefreshed extends GamestateState {}
final class NextPage extends GamestateState{}
final class GameOver extends GamestateState{}
