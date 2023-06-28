part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserStateLoading extends UserState {}
class UserStateShow extends UserState {}
class UserStateUpdate extends UserState {}
class UserStateError extends UserState {
  UserStateError(this.err);
  final String err;
}