import 'package:flutter/material.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/services/auth_service.dart';
import 'package:scapps_student/utils/theme.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;

  HomePage({Key key, this.authBloc}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: height * 0.2,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xFF333333),
                ),
              ),
              Positioned(
                bottom: 40,
                right: 20,
                child: RichText(
                    text: TextSpan(
                        text: "Selamat Pagi,\n",
                        style: textNormal.copyWith(color: Color(0xFFF3F3F3)),
                        children: [
                      TextSpan(
                          text: "Junianto",
                          style: textNormal.copyWith(color: Colors.white))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
