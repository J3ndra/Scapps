import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class GetToken extends AuthEvent {
  final String token;

  GetToken(this.token);

  @override
  List<Object> get props => [token];
}

class GoToMainPage extends AuthEvent {
  final int bottomNavBarIndex;

  GoToMainPage({this.bottomNavBarIndex});

  @override
  List<Object> get props => [bottomNavBarIndex];
}

class AuthIsExpired extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class LoginProcess extends AuthEvent {
  final String email;
  final String password;

  LoginProcess({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
