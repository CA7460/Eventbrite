import 'package:event_app/modules/app_features/discussion/local_widgets/public_chat_message.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatWindow extends StatefulWidget {
  final ScrollController controller;
  const ChatWindow({
    Key? key, 
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
    // return FutureBuilder(
    //   future: getMessagesForConversation('Dan'),
    //   builder: (context, snapshot) {
    //     if(snapshot.hasData) {
          //if(isFirstBuild){
            //messages = snapshot.data as List<Message>;
          //}
          final List<Message> messages = Provider.of<MessageList>(context).messageList;
          return ListView.builder(
            controller: widget.controller,
            itemBuilder: (context, index) {
              final now = DateTime.now();
              final difference = now.difference(messages[index].sentAt);
              return GestureDetector(
                child: PublicChatMessage(
                  senderName: messages[index].sentBy,
                  content: messages[index].content,
                  isSender: messages[index].sentBy == 'Ian'? true: false,
                  isSeen: messages[index].isSeen,
                  isExpanded: index == tappedIndex? true: false,
                  sentAt: timeago.format(now.subtract(difference), locale: 'en_short'),
                ),
                onTap: () => _expandChat(index),
              );
            },
            itemCount: messages.length,
          );
      // } else {
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }
    // });
  }
}