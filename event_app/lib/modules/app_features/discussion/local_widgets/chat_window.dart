import 'dart:developer';

import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/public_chat_message.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatWindow extends StatefulWidget {
  final String convoId;
  final ScrollController controller;
  const ChatWindow({
    Key? key, 
    required this.convoId,
    required this.controller,
  }) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {

  int? tappedIndex;
  bool isFirstBuild = true;

 

  _expandChat(index) {
    setState(() {
      if(tappedIndex != index) {
        tappedIndex = index;
      } else {
        tappedIndex = null;
      }
    });
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MessageList messageList = Provider.of<MessageList>(context);
    LoggedUser loggedUser = Provider.of<LoggedUser>(context);
    if (isFirstBuild) {
      messageList.loadMessages(widget.convoId);
      isFirstBuild = false;
    }          
    // List<Message> messages = messageList.messageList;
    return Container(
      color: primary_background,
      child: ListView.builder(
        controller: widget.controller,
        itemBuilder: (context, index) {
          final now = DateTime.now();
          final difference = now.difference(messageList.messageList[index].sentAt);
          return GestureDetector(
            child: PublicChatMessage(
              senderName: messageList.messageList[index].sentBy.prenom,
              content: messageList.messageList[index].content,
              isSender: messageList.messageList[index].sentBy.userid == loggedUser.user!.userid? true: false,
              isSeen: messageList.messageList[index].isSeen,
              isExpanded: index == tappedIndex? true: false,
              sentAt: timeago.format(now.subtract(difference), locale: 'en_short'),
            ),
            onTap: () => _expandChat(index),
          );
        },
        itemCount: messageList.messageList.length,
      ),
    );
  }
}