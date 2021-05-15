import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class AuthExpired extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class LoginProcess extends AuthEvent {
  final String email;
  final String password;

  LoginProcess({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
