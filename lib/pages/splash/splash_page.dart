import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:scapps_student/pages/login/welcome_login.dart';
// import 'package:scapps_student/utils/navigator_helper.dart';
import 'package:scapps_student/utils/theme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeLogin())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        // child: Image.asset("assets/images/logo.svg"),
                        child: SvgPicture.asset("assets/images/logo.svg"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      Text("Aplikasi\nSekolah Pintar",
                          textAlign: TextAlign.center, style: textTitle)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 76,
                        height: 22,
                        child: SvgPicture.asset("assets/images/powered.svg")),
                    Padding(padding: EdgeInsets.only(bottom: 20.0))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
