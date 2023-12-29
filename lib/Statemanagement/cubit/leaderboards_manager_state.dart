part of 'leaderboards_manager_cubit.dart';

@immutable
sealed class LeaderboardsManagerState {}

final class LeaderboardsManagerInitial extends LeaderboardsManagerState {}
final class LeaderbaordsManagerRefresh extends LeaderboardsManagerState{}
final class LeaderbaordsManagerDone extends LeaderboardsManagerState{}