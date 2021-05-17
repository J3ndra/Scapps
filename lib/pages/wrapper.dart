import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/pages/login/login_page.dart';
import 'package:scapps_student/pages/student/home/student_home_page.dart';
import 'package:scapps_student/pages/student/student_main_page.dart';
import 'package:scapps_student/pages/teacher/home/teacher_home_page.dart';
import 'package:scapps_student/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WelcomeLogin extends StatefulWidget {
  @override
  _WelcomeLoginState createState() => _WelcomeLoginState();
}

class _WelcomeLoginState extends State<WelcomeLogin> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return AuthBloc(authService: authService);
        },
        child: WelcomeLoginPage(
          authService: authService,
          authBloc: AuthBloc(authService: authService),
        ));
  }
}

// ignore: must_be_immutable
class WelcomeLoginPage extends StatelessWidget {
  final AuthService authService;
  final AuthBloc authBloc;
  DateTime currentBackPressTime;

  WelcomeLoginPage({Key key, this.authService, this.authBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is AuthInit) {
            authBloc.add(AuthCheck());
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AuthStudentHasToken || state is AuthOnMainPage)
            return StudentMainPage(authBloc: authBloc);
          if (state is AuthTeacherHasToken || state is GoToMainPage)
            return TeacherHomePage(authBloc: authBloc);
          if (state is AuthExpired) return LoginPage(authBloc: authBloc);
          if (state is AuthFailed || state is LoginFailed)
            return LoginPage(authBloc: authBloc);
          if (state is AuthLoading)
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          return Scaffold();
        });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tekan sekali lagi untuk keluar dari aplikasi.");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
