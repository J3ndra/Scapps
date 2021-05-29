import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapps_student/blocs/auth/auth_bloc.dart';
import 'package:scapps_student/pages/login/login_form.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const LoginPage({Key key, this.authBloc, this.analytics, this.observer})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: LoginForm(
          authBloc: _authBloc,
          analytics: widget.analytics,
          observer: widget.observer),
    );
  }
}
