part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserEventUpdate extends UserEvent {
  UserEventUpdate(this.name);
  final String name;
}

class UserEventUpdatePhoto extends UserEvent {
  final File photo;
  UserEventUpdatePhoto(this.photo);
}

class UserEventOnline extends UserEvent {
  final bool isOnline;
  UserEventOnline(this.isOnline);
}
