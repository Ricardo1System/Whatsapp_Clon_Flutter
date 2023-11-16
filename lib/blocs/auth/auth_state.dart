part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class SendCodeLoading extends AuthState {}
class SendCodeLoaded extends AuthState {}
class AuthAuthenticate extends AuthState {}
class AuthUnauthenticate extends AuthState {}
class AuthError extends AuthState {}


