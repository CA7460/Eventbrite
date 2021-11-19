import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/widgets/textfield_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({
    Key? key,
    required this.controller,
    this.hintText,
    this.icon = Icons.lock,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController controller;
  final IconData icon;

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {

  bool _hidePassword = true;

  void _toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      backgroundColor: Colors.black,
      child: TextFormField(
        style: TextStyle(color: primary_green),
        obscureText: _hidePassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: eventbrite_red,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _hidePassword ?
              Icons.visibility : 
              Icons.visibility_off
              , color: eventbrite_red,
            ),
            onPressed: _toggleVisibility,
          ),
          border: UnderlineInputBorder(),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: primary_green)
          ),
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}