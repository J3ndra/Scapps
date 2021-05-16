import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/pages/login/login_page.dart';
import 'package:scapps_student/pages/login/welcome_login.dart';
import 'package:scapps_student/pages/splash/splash_page.dart';
import 'package:scapps_student/pages/student_home/student_home_page.dart';
import 'package:scapps_student/pages/teacher_home/teacher_home_page.dart';
import 'package:scapps_student/services/auth_service.dart';

var routes = <String, WidgetBuilder>{
  "/welcomeLogin": (BuildContext context) => WelcomeLogin(),
  "/login": (BuildContext context) => LoginPage(),
  "/homeStudent": (BuildContext context) => StudentHomePage(),
  "/homeTeacher": (BuildContext context) => TeacherHomePage()
};

// void main() => runApp(new MaterialApp(
//     title: "Asep's",
//     theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.black),
//     debugShowCheckedModeBanner: false,
//     home: SplashPage(),
//     routes: routes));

void main() {
  final AuthService authService = AuthService();
  runApp(MaterialApp(
    title: "Asep's",
    theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.black),
    debugShowCheckedModeBanner: false,
    routes: routes,
    home: BlocProvider(
      create: (context) {
        return AuthBloc(authService: authService);
      },
      child: SplashPage(),
    ),
  ));
}
