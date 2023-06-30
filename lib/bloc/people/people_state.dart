part of 'people_bloc.dart';

@immutable
abstract class PeopleState {}

class PeopleInitial extends PeopleState {}
class PeopleStateLoading extends PeopleState {}
class PeopleStateShow extends PeopleState {}

class PeopleStateError extends PeopleState {
  final String err;
  PeopleStateError(this.err);
}