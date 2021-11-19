import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/models/current_event.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_list.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'conversation_item.dart';

class ChatList extends StatelessWidget {
  final ConversationType conversationType;
  final Function(Conversation) onTap;
  const ChatList({
    Key? key,
    required this.onTap(index),
    required this.conversationType
  }) : super(key: key);

  String _stringMembers(List<User> members, String loggedUser) {
    String string = '';
    for(var member in members) {
      if (member.userid != loggedUser) {
        string += member.prenom;
      }
    }
    return string;
  }

  List<Conversation> _makeConvoList(conversations) {
    List<Conversation> toReturn = [];
    for(var convo in conversations) {
      Conversation conversation = Conversation.fromJson(convo);
      toReturn.add(conversation);
    }
    toReturn.sort((a,b) => a.updatedAt.compareTo(b.updatedAt));
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    final LoggedUser loggedUser = Provider.of<LoggedUser>(context);
    final CurrentEvent currentEvent = Provider.of<CurrentEvent>(context);
    final ConversationList currentConvos = Provider.of<ConversationList>(context);
    currentConvos.loadConversations(loggedUser.user!.mail, currentEvent.event!.eventid);
    final List<Conversation> conversations = currentConvos.convoList;
    var listedConversations = conversations.where((conversation) => conversation.type == conversationType).toList();
    return SafeArea(
      child: Container(
        color: primary_background,
        child: ListView.builder(
          itemBuilder: (context, index) {
            var otherMembers = _stringMembers(listedConversations[index].members, loggedUser.user!.userid);
            final now = DateTime.now();
            final difference = now.difference(listedConversations[index].updatedAt);
            return GestureDetector(
              onTap: () => onTap(listedConversations[index]),
              child: ConversationItem(
                title: listedConversations[index].title == null? otherMembers: listedConversations[index].title!,
                // lastMessage: listedConversations[index].lastMessage == null? null: listedConversations[index].lastMessage!.content, 
                updatedAt: timeago.format(now.subtract(difference), locale: 'en_short')
              ),
            );
          },
          itemCount: listedConversations.length
        ),
      )
    );
  }
}