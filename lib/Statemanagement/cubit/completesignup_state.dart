part of 'completesignup_cubit.dart';

@immutable
sealed class CompletesignupState {}

final class CompletesignupInitial extends CompletesignupState {}

final class CompletesignupRequest extends CompletesignupState {}
final class CompletesignupError extends CompletesignupState {}
final class CompletesignupLoading extends CompletesignupState {}
final class CompletesignupSuccess extends CompletesignupState {}
final class GameDoneLeaderboardRedirect extends CompletesignupState{}