part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserEventUpdate extends UserEvent {
  UserEventUpdate(this.name);
  final String name;
}
class UserEventPhoto extends UserState {
  final String photo;
  UserEventPhoto(this.photo);
}