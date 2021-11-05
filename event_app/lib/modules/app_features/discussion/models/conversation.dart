import 'conversation_type.dart';

class Conversation {
  //String groupId;
  String convoId;
  String title;
  String lastMessage;
  ConversationType type;
  DateTime updatedAt;

  Conversation(this.convoId, this.title, this.lastMessage, this.type, this.updatedAt);

  Conversation.fromJson(Map<String, dynamic> json)
    : 
      convoId = json['convoid'],
      //groupId = json['groupid'],
      title = json['title'],
      lastMessage = json['lastMessage'],
      type = ConversationType.values.firstWhere((e) => e.toString() == json['type']),
      updatedAt = DateTime.parse(json['updatedat']);

}