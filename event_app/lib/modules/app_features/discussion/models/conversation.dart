import 'conversation_type.dart';

class Conversation {
  String title;
  String lastMessage;
  ConversationType type;
  DateTime updatedAt;

  Conversation(this.title, this.lastMessage, this.type, this.updatedAt);

}