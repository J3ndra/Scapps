import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scapps_student/utils/theme.dart';

class EmailField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController emailController;
  const EmailField(
      {Key key,
      this.hintText,
      this.icon = Icons.mail,
      this.onChanged,
      this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: textNormal.copyWith(color: Color(0xff808080)),
        controller: emailController,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 20, bottom: 20, right: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: new OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(
              icon,
              color: Color(0xFF808080),
            ),
          ),
          hintText: hintText,
        ));
  }
}
