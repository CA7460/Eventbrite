import 'dart:convert';

import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:flutter/foundation.dart';

import 'conversation_type.dart';

class Conversation {
  //String groupId;
  String? convoId;
  String? title;
  List<User> members;
  // Message? lastMessage;
  ConversationType type;
  DateTime updatedAt;

  Conversation(this.convoId, this.title, this.members, this.type, this.updatedAt);

  Conversation.fromNewMessage(this.title, this.members, this.type, this.updatedAt);

  Conversation.fromJson(Map<String, dynamic> theJson)
    : convoId = theJson['convoId'],
      title = theJson['title'],
      members = (theJson['members'] as List).map<User>((dynamic user) => User.fromJson(user)).toList(),
      // lastMessage = Message.fromJson(theJson['lastMessage']),
      type = ConversationType.values.firstWhere((e) => describeEnum(e) == theJson['type']),
      updatedAt = DateTime.parse(theJson['updatedAt']);

  Map<String, dynamic> toJson(){
    return {
      "convoId": convoId ?? null,
      "title": title ?? null,
      "members": members.map((e) => e.toJson()).toList(),
      // "lastMessage": lastMessage ?? null,
      "type": describeEnum(type),
      "updatedAt": updatedAt.toString()
    };  
  }  
}