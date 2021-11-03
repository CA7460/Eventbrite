import 'package:flutter/material.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({
    Key? key,
  }) : super(key: key);


  @override
  State<NewMessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<NewMessageScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container()
      )
    );
  }
}