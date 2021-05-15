import 'package:flutter/material.dart';
import 'package:scapps_student/widgets/text_field_container.dart';

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
    return TextFieldContainer(
      child: TextField(
        controller: emailController,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF808080),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
