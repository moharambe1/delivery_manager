part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthinProgressState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailedState extends AuthState {}

class AuthSiccafluid extends AuthState {}

class AuthFailed extends AuthState {}
