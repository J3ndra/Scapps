import 'package:equatable/equatable.dart';
import 'package:scapps_student/models/login_model.dart';

// Auth
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class AuthStudentHasToken extends AuthState {
  final String token;
  AuthStudentHasToken({this.token});

  @override
  List<Object> get props => [token];
}

class AuthTeacherHasToken extends AuthState {
  final String token;
  AuthTeacherHasToken({this.token});

  @override
  List<Object> get props => [token];
}

class StudentProfile extends AuthState {
  final String name;
  final String email;
  final String nisn;
  final String image;

  StudentProfile({this.name, this.email, this.nisn, this.image});

  @override
  List<Object> get props => [name, email];
}

class AuthRoleNotFound extends AuthState {}

class AuthExpired extends AuthState {}

class AuthFailed extends AuthState {}

class AuthData extends AuthState {
  final Data data;
  final String token;
  final Meta meta;

  AuthData({this.data, this.token, this.meta});

  @override
  List<Object> get props => [data, token, meta];
}

// Login
class LoginInit extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailed extends AuthState {
  final String error;

  LoginFailed(this.error);

  @override
  List<Object> get props => [error];
}
