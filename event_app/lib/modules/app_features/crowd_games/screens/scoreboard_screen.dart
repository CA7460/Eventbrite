import 'package:flutter/material.dart';

class ScoreboardScreen extends StatelessWidget {
  const ScoreboardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Scoreboard Screen", style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}