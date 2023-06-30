part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserStateInitial extends UserState {}
class UserStateLoading extends UserState {}

class UserStateUpdatePhoto extends UserState {}
class UserStateUpdate extends UserState {}

class UserStateSuccess extends UserState {
  UserStateSuccess(this.message);
  final String message;
}
class UserStateError extends UserState {
  UserStateError(this.err);
  final String err;
}