import 'package:flutter/material.dart';

class GameRoomScreen extends StatefulWidget {
  const GameRoomScreen({ Key? key }) : super(key: key);

  @override
  _GameRoomScreenState createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Game room Screen", style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}