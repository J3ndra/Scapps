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
      if (hasToken != null) {
        final bool tokenExpired = JwtDecoder.isExpired(hasToken);
        if (tokenExpired != false) {
          await authService.unsetLocalToken();
          yield AuthExpired();
        } else {
          yield AuthHasToken(token: hasToken);
        }
      } else {
        yield AuthFailed();
      }
    }

    if (event is LoginProcess) {
      yield AuthLoading();

      try {
        final login =
            await authService.loginStudent(event.email, event.password);
        if (login.meta.success != false) {
          yield LoginSuccess();
          await authService.setLocalToken(login.token);
          yield AuthHasToken(token: login.token);
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
          await authService.unsetLocalToken();
          yield AuthFailed();
        }
      } catch (e) {}
    }

    if (event is LoggedOut) {
      final String token = await authService.hasToken();
      // print(token);

      try {
        final LogoutModel logout = await authService.logoutStudent(token);
        if (logout.meta.success != false || logout.meta.success != true) {
          print("message = " + logout.meta.message);
          await authService.unsetLocalToken();
          yield AuthFailed();
        }
      } catch (e) {}
    }
  }
}
