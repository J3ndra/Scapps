import 'package:flutter/material.dart';
import 'package:scapps_student/utils/theme.dart';

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController passwordController;
  const PasswordField({Key key, this.onChanged, this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textNormal.copyWith(color: Color(0xff808080)),
      controller: passwordController,
      obscureText: true,
      onChanged: onChanged,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 20, bottom: 20, right: 20),
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
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            Icons.lock,
            color: Color(0xFF808080),
          ),
        ),
      ),
    );
  }
}
