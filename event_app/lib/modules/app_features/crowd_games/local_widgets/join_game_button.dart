import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/styles.dart';

class JoinGameButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  const JoinGameButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: textbox_background,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        fixedSize: Size(96, 0),
        textStyle: buttonStyle,
      ),
      child: Text(
        "JOIN GAME",
        style: TextStyle(
            color: primary_green, fontSize: 10, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
