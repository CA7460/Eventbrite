import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/repositories/messenger_helper.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'conversation_item.dart';

class ChatList extends StatelessWidget {
  final ConversationType conversationType;
  final Function(String) onTap;
  const ChatList({
    Key? key,
    required this.onTap(index),
    required this.conversationType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User loggedUser = Provider.of<User>(context);
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
                onTap: () => onTap(listedConversations[index].convoId),
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
      future: getConversationsForUser(loggedUser.userid))
    );
  }
}