import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/pages/home/home_page.dart';
import 'package:scapps_student/pages/login/login_page.dart';
import 'package:scapps_student/services/auth_service.dart';
// import 'package:scapps_student/utils/navigator_helper.dart';
import 'package:scapps_student/utils/theme.dart';
import 'package:scapps_student/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
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
          if (state is AuthHasToken || state is AuthData)
            return HomePage(authBloc: authBloc);
          if (state is AuthFailed || state is LoginFailed)
            return LoginPage(authBloc: authBloc);
          if (state is AuthLoading)
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          return Scaffold(
            backgroundColor: Colors.white,
            body: WillPopScope(
                child: Stack(
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
                                  child: SvgPicture.asset(
                                      "assets/images/logo.svg"),
                                ),
                                Padding(padding: EdgeInsets.only(top: 30.0)),
                                Text("Selamat Datang\nAplikasi Sekolah Pintar",
                                    textAlign: TextAlign.center,
                                    style: textTitle)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPage(authBloc: authBloc)));
                                  },
                                  child: PrimaryButton(buttonText: 'Masuk'),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 20.0)),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: textNormal,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "'By continuing with the services above, you agree to Asep's"),
                                      TextSpan(
                                          text: 'Terms of Service',
                                          style: textLink,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print('Terms of Service"');
                                            }),
                                      TextSpan(text: ' and '),
                                      TextSpan(
                                          text: 'Privacy Policy',
                                          style: textLink,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print('Privacy Policy"');
                                            }),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                onWillPop: onWillPop),
          );
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
