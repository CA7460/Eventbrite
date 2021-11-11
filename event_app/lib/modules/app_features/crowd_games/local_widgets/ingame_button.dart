import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/styles.dart';

class InGameButton extends StatefulWidget {
  final String btnText;
  Color color;
  final GestureTapCallback onPressed;
  InGameButton(
      {required this.btnText, required this.color, required this.onPressed});

  @override
  State<InGameButton> createState() => _InGameButtonState();
}

class _InGameButtonState extends State<InGameButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget.color,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        fixedSize: Size(122, 0),
        textStyle: buttonStyle,
      ),
      child: Text(
        widget.btnText,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      onPressed: widget.onPressed,
    );
  }
}
