import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/widgets/textfield_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    Key? key,
    required this.controller,
    this.hintText,
    //this.icon = Icons.person,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController controller;
  // final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      backgroundColor: Colors.white,
      child: TextFormField(
        style: TextStyle(color: black),
        decoration: InputDecoration(
          icon: Icon(
            Icons.mail,
            color: Colors.black26,
          ),
          border: InputBorder.none,
          hintText: hintText, 
          hintStyle: TextStyle(color: Colors.black26)
          ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          } else if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}