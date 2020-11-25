part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final Auth auth;

  LoginSuccess({this.auth});

  @override
  List<Object> get props => [auth];
}

class LoginError extends LoginState {
  final String error;

  LoginError({this.error});

  @override
  List<Object> get props => [error];
}
