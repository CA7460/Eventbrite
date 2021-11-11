import 'dart:convert';

import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';

import 'conversation_type.dart';

class Conversation {
  //String groupId;
  String? convoId;
  String? title;
  List<User> members;
  Message? lastMessage;
  ConversationType type;
  DateTime updatedAt;

  Conversation(this.convoId, this.title, this.members, this.lastMessage, this.type, this.updatedAt);

  Conversation.fromNewMessage(this.title, this.members, this.type, this.updatedAt);

  Conversation.fromJson(Map<String, dynamic> theJson)
    : convoId = theJson['convoid'],
      title = theJson['title'],
      members = (json.decode(theJson['members'])).map<User>((dynamic user) => User.fromJson(user)).toList(),
      //members = List<User>.from(json.decode(theJson['members']).map((i) => User.fromJson(i))),   //this is weird
      lastMessage = Message.fromJson(theJson['lastMessage']),
      type = ConversationType.values.firstWhere((e) => e.toString() == theJson['type']),
      updatedAt = DateTime.parse(theJson['updatedat']);

  Map<String, dynamic> toJson(){
    return {
      "convoId": convoId,
      "title": title,
      "members": members.map((e) => e.userid),
      "lastMessage": lastMessage?.messageId,
      "type": type.toString().split('.').last,
      "updatedAt": updatedAt
    };  
  }  
}



// Message(
//         json['lastmessage']['sentby'],
//         json['lastmessage']['content'],
//         DateTime.parse(json['lastmessage']['sentat']),
//         json['lastmessage']['sentat'])