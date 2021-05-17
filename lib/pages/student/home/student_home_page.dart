import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/services/auth_service.dart';
import 'package:scapps_student/utils/theme.dart';
import 'package:scapps_student/widgets/primary_button.dart';

class StudentHomePage extends StatefulWidget {
  final AuthBloc authBloc;

  StudentHomePage({Key key, this.authBloc}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final AuthService authService = AuthService();
  AuthBloc get _authBloc => widget.authBloc;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _authBloc,
          // ignore: missing_return
          builder: (context, state) {
            if (state is AuthStudentHasToken) {
              _authBloc.add(GetStudentUserProfile(state.token));
              return Container();
            }
            if (state is StudentProfile) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nama : " + state.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Email : " + state.email,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              );
            }
          }),
    );
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
