import 'package:flutter/material.dart';

class NavigatorHelper {
  static void goToWelcomeLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/welcomeLogin");
  }

  // static void goToLogin(BuildContext context) {
  //   Navigator.pushNamed(context, "/login");
  // }
}
