import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class MainWallScreen extends StatefulWidget {
  const MainWallScreen({Key? key}) : super(key: key);
  @override
  _MainWallState createState() => _MainWallState();
}

class _MainWallState extends State<MainWallScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: Text("Main Wall - Erreur de connecxion",
                style: TextStyle(color: primary_blue, fontSize: 20))));
  }
}
