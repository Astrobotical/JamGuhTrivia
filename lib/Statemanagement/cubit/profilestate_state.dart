part of 'profilestate_cubit.dart';

@immutable
sealed class ProfilestateState {}

final class ProfilestateInitial extends ProfilestateState {}
final class ProfilestateDone extends ProfilestateState{}
final class ProfilestateRefresh  extends ProfilestateState{}