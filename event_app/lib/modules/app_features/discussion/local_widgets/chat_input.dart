import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final VoidCallback onSubmit;
  final TextEditingController controller;
  const ChatInput({
    Key? key,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: const BoxDecoration(
        color: black
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18,0,0,0),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.59,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.grey.shade800
            ),
            child: TextField(
              controller: widget.controller,
              style: const TextStyle(
                fontSize: 16
                
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
          ),
          const SizedBox(width: 8,),
          IconButton(onPressed: widget.onSubmit, icon: const Icon(Icons.send), iconSize: 18, color: primary_blue,)
        ],
      ),
    );
  }
}