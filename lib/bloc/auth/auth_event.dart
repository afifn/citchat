part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin(this.email, this.password);
}

class AuthEventRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;
  AuthEventRegister(this.name, this.email, this.password);
}

class AuthEventLogout extends AuthEvent {}