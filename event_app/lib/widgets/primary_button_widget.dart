import 'package:flutter/material.dart';
import 'package:event_app/config/theme/styles.dart';

class PrimaryButton extends StatelessWidget {

  final String btnText;
  final Color btnColor;
  final GestureTapCallback onPressed;
  const PrimaryButton(this.btnText, this.btnColor, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        fixedSize: Size(238, 50),
        textStyle: buttonStyle,
      ),
      child: Text(
        btnText.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
