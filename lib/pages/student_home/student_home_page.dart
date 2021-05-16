import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
              bool expiredToken = JwtDecoder.isExpired(state.token);
              print(expiredToken.toString());
              return WillPopScope(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Halaman Siswa"),
                        Text(
                          "Token : " + state.token,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Email : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _authBloc.add(LoggedOut());
                          },
                          child: Text("Logout"),
                        )
                      ],
                    ),
                  ),
                  onWillPop: onWillPop);
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
