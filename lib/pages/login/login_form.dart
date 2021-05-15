import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_event.dart';
import 'package:scapps_student/blocs/auth/auth_state.dart';
import 'package:scapps_student/utils/theme.dart';
import 'package:scapps_student/widgets/primary_button.dart';
import 'package:scapps_student/widgets/email_field.dart';
import 'package:scapps_student/widgets/password_field.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  final AuthBloc authBloc;

  LoginForm({Key key, this.authBloc}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: authBloc,
      builder: (context, state) {
        return Scaffold(
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
                          Text(
                            "Selamat Datang",
                            style: textTitle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Silahkan masuk untuk melanjutkan",
                            style: textButton.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          EmailField(
                            emailController: emailController,
                            hintText: "Surel",
                            onChanged: (value) {},
                          ),
                          PasswordField(
                            passwordController: passwordController,
                            onChanged: (value) {},
                          ),
                          (state is LoginFailed)
                              ? Text(
                                  "Surel atau kata sandi yang Anda masukkan salah!",
                                  style: textNormal.copyWith(
                                      color: Color(0xFFCF4545)),
                                )
                              : Text("")
                        ],
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
                              onTap: _loginAttempt,
                              child: PrimaryButton(
                                  buttonText: (state is AuthLoading)
                                      ? "Mohon tunggu sebentar."
                                      : "Masuk"),
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
                ),
              ),
            ],
          ),
        ));
      },
    );
  }

  void _loginAttempt() {
    print(emailController.text + "," + passwordController.text);
    authBloc.add(LoginProcess(
        email: emailController.text, password: passwordController.text));
  }
}
