import 'package:flutter/material.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({
    Key? key,
  }) : super(key: key);


  @override
  State<NewMessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<NewMessageScreen> {

  //Send a message
    //take receivers as argument, checks if group exists
      //sends message to right conversation if it does
    //else
      //Creates a new conversation if it doesnt
        //Sends message to new conversation

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