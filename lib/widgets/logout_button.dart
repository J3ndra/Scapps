import 'package:flutter/material.dart';
import 'package:scapps_student/utils/theme.dart';

class LogoutButton extends StatelessWidget {
  final String buttonText;
  LogoutButton({@required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.red),
        child: Text(
          buttonText,
          style: textButton.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
