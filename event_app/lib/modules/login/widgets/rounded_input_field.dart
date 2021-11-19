import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/widgets/textfield_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    Key? key,
    required this.controller,
    this.hintText,
    this.icon = Icons.person,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      backgroundColor: Colors.black,
      child: TextFormField(
        style: TextStyle(color: primary_pink),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: eventbrite_red,
          ),
          border: UnderlineInputBorder(),
          hintText: hintText, 
          hintStyle: TextStyle(color: primary_pink)
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