import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/utils/theme.dart';
import 'package:scapps_student/widgets/primary_button.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  final AuthBloc authBloc;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  LoginForm({Key key, this.authBloc, this.analytics, this.observer})
      : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueChanged<String> onChanged;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    return BlocBuilder(
      bloc: authBloc,
      builder: (context, state) {
        return WillPopScope(
            child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    "Selamat Datang",
                                    style: textTitle,
                                  ),
                                  Text(
                                    "Silahkan masuk untuk melanjutkan",
                                    style: textButton.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextField(
                                      style: textNormal.copyWith(
                                          color: Color(0xff808080)),
                                      controller: emailController,
                                      onChanged: onChanged,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 20, bottom: 20, right: 20),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: new OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10),
                                          child: Icon(
                                            Icons.mail,
                                            color: Color(0xFF808080),
                                          ),
                                        ),
                                        hintText: "Alamat Surel",
                                      )),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TextField(
                                    style: textNormal.copyWith(
                                        color: Color(0xff808080)),
                                    controller: passwordController,
                                    obscureText: true,
                                    onChanged: onChanged,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 20, bottom: 20, right: 20),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(8.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      hintText: "Kata Sandi",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: Icon(
                                          Icons.lock,
                                          color: Color(0xFF808080),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  (state is LoginFailed)
                                      ? Text(
                                          "Surel atau kata sandi yang Anda masukkan salah!",
                                          style: textNormal.copyWith(
                                              color: Color(0xFFCF4545)),
                                        )
                                      : Text(""),
                                  (state is AuthExpired)
                                      ? Text("Sesi login Anda telah selesai!",
                                          style: textNormal.copyWith(
                                              color: Color(0xFFCF4545)))
                                      : Text("")
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: _loginAttempt,
                                      child: PrimaryButton(
                                          buttonText: (state is AuthLoading)
                                              ? "Mohon tunggu sebentar."
                                              : "Masuk"),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20.0)),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: textNormal.copyWith(
                                            color: Color(0xFF808080)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "By continuing with the services above, you agree to Asep's"),
                                          TextSpan(
                                              text: ' Terms of Service',
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
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 10.0)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            onWillPop: onWillPop);
      },
    );
  }

  Future<void> _loginAttempt() async {
    authBloc.add(LoginProcess(
        email: emailController.text, password: passwordController.text));
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
