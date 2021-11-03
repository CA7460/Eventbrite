import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/conversation.dart';
import 'package:flutter_application_1/models/conversation_type.dart';
import 'package:flutter_application_1/services/messenger_helper.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'conversation_item.dart';

class ChatList extends StatelessWidget {
  final ConversationType conversationType;
  const ChatList({
    Key? key,
    required this.conversationType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(builder: (context, snapshot) {
        if(snapshot.hasData) {
          var conversations = snapshot.data as List<Conversation>;
          var listedConversations = conversations.where((conversation) => conversation.type == conversationType).toList();
          return ListView.builder(
            itemBuilder: (context, index) {
              final now = DateTime.now();
              final difference = now.difference(listedConversations[index].updatedAt);
              return GestureDetector(
                onTap: () => print('conversation picked'),
                child: ConversationItem(
                  title: listedConversations[index].title,
                  lastMessage: listedConversations[index].lastMessage, 
                  updatedAt: timeago.format(now.subtract(difference), locale: 'en_short')
                ),
              );
            },
            itemCount: listedConversations.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: getConversationForUser(),)
    );
  }
}