import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/services/auth_service.dart';
import 'package:scapps_student/utils/theme.dart';
import 'package:scapps_student/widgets/photo_profile.dart';
import 'package:scapps_student/widgets/primary_button.dart';

class StudentProfilePage extends StatefulWidget {
  final AuthBloc authBloc;

  StudentProfilePage({Key key, this.authBloc}) : super(key: key);

  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final AuthService authService = AuthService();
  AuthBloc get _authBloc => widget.authBloc;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
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
              return Scaffold(
                  body: WillPopScope(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          PhotoProfile(
                            image: state.image,
                            name: state.name,
                            nisn: state.nisn,
                          )
                        ]),
                      ),
                      onWillPop: onWillPop));
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
