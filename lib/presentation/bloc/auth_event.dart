part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String pwd;
  const LoginEvent({required this.email, required this.pwd});

  @override
  List<Object> get props => [email, pwd];
}

class IsAuthEvent extends AuthEvent {}

class TryLoginEvent extends AuthEvent {}
