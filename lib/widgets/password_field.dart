import 'package:flutter/material.dart';
import 'package:scapps_student/widgets/text_field_container.dart';

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController passwordController;
  const PasswordField({Key key, this.onChanged, this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: passwordController,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Kata Sandi",
          icon: Icon(
            Icons.lock,
            color: Color(0xFF808080),
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFF808080),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
