part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthStateInitialize extends AuthState {}
class AuthStateLogin extends AuthState {}

class AuthStateRegister extends AuthState {}
class AuthStateSuccess extends AuthState {
  final String message;
  AuthStateSuccess(this.message);
}
class AuthStateLoading extends AuthState {}
class AuthStateLogout extends AuthState {}
class AuthStateError extends AuthState {
  final String error;
  AuthStateError({required this.error});
}