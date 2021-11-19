import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const TextFieldContainer({ Key? key, required this.backgroundColor, required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(29)
      ),
      child: child,
    );
  }
}