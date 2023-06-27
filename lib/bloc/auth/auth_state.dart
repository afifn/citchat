part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthStateInitialize extends AuthState {}
class AuthStateLogin extends AuthState {}
class AuthStateRegister extends AuthState {}
class AuthStateLoading extends AuthState {}
class AuthStateLogout extends AuthState {}
class AuthStateError extends AuthState {
  final String error;
  AuthStateError({required this.error});
}