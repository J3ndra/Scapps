import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/models/logout_model.dart';
import 'package:scapps_student/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({this.authService})
      : assert(authService != null),
        super(AuthInit());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthCheck) {
      yield AuthLoading();

      final hasToken = await authService.hasToken();
      final hasRole = await authService.hasRole();
      print("Do Auth Check");
      if (hasToken != null) {
        final bool tokenExpired = JwtDecoder.isExpired(hasToken);
        print('Auth check token is expired?' + tokenExpired.toString());
        if (tokenExpired != false) {
          await authService.unsetAll();
          yield AuthExpired();
        } else {
          // yield AuthHasToken(token: hasToken);
          if (hasRole != null) {
            if (hasRole == "teacher") {
              yield AuthTeacherHasToken(token: hasToken);
            } else if (hasRole == "student") {
              yield AuthStudentHasToken(token: hasToken);
            } else {
              AuthRoleNotFound();
            }
          }
        }
      } else {
        yield AuthFailed();
      }
    }

    if (event is GetStudentUserProfile) {
      yield AuthLoading();
      print('Do GetStudentUserProfile');
      try {
        final bool tokenExpired = JwtDecoder.isExpired(event.token);
        print("GetStudentUserProfile token expired?" + tokenExpired.toString());

        if (tokenExpired != false) {
          await authService.unsetAll();
          yield AuthExpired();
        } else {
          print('Token is not expired');
          final user = await authService.getStudentProfile(event.token);
          print("Success GetStudentUserProfile");
          yield StudentProfile(
              email: user.data.email,
              name: user.data.name,
              nisn: user.data.student.nisn,
              image: user.data.student.image);
        }
      } catch (e) {}
    }

    if (event is LoginProcess) {
      yield AuthLoading();

      try {
        final login =
            await authService.loginStudent(event.email, event.password);
        if (login.meta.success != false) {
          yield LoginSuccess();
          await authService.setLocalTokenAndRole(login.token, login.data.role);
          print("Role = " + login.data.role);
          if (login.data.role == "student") {
            yield AuthStudentHasToken(token: login.token);
          } else if (login.data.role == "teacher") {
            yield AuthTeacherHasToken(token: login.token);
          } else {
            yield AuthRoleNotFound();
          }
        }
      } catch (e) {
        yield LoginFailed("Login Failed!");
      }
    }

    if (event is AuthIsExpired) {
      final String token = await authService.hasToken();
      try {
        final bool tokenExpired = JwtDecoder.isExpired(token);

        if (tokenExpired != false) {
          await authService.unsetAll();
          yield AuthFailed();
        }
      } catch (e) {}
    }

    if (event is LoggedOut) {
      final String token = await authService.hasToken();

      try {
        final LogoutModel logout = await authService.logoutStudent(token);
        if (logout.meta.success != false || logout.meta.success != true) {
          print("message = " + logout.meta.message);
          await authService.unsetAll();
          yield AuthFailed();
        }
      } catch (e) {}
    }
  }
}
