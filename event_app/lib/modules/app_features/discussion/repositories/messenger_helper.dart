import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';

Future<List<Conversation>> getConversationForUser() async {
  List<Conversation> conversations = [];
  conversations.add(Conversation('1','Tatiana', 'Boff, je prefere la tequila moi!', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('2','Dom', 'Ben, arrete de boire ma biere!', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('3','Don', 'Treat yourself!', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('4','General Discussion', 'Le deuxieme stage est malade!', ConversationType.public, DateTime.now()));
  conversations.add(Conversation('5','Justine', 'Check comment la tomate est cute!', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('6','Chloe', 'Tchiups! Ian, tu ne peux pas sortir avec cette tete la!', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('7','Camping', 'Yen a tu qui cherchent une tente a squatter?', ConversationType.public, DateTime.now()));
  conversations.add(Conversation('8','Gilles', 'Ian, tu es sorti sans faire ton lit...', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('9','Mom', 'Passes une bonne journee mon coeur!', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('10','Georges', 'Yo G! Check this WIP I just started', ConversationType.private, DateTime.now()));
  conversations.add(Conversation('11','Dan', 'Le cout sera de 10 dollars par personne', ConversationType.carpool, DateTime.now()));
  return conversations;
}


Future<List<Message>> getMessagesForConversation(convoId) async {
  List<Message> messages = [];
  messages.add(Message('Ian', 'Bonjour, je suis interesse pour une place ds votre covoiturage', DateTime.now(), true));
  messages.add(Message('Dan', 'Il reste quelques places!', DateTime.now(), true));
  messages.add(Message('Ian', 'Elles sont a combien et vous partez de ou?', DateTime.now(), true));
  messages.add(Message('Dan', 'Cest marque dans mon post...', DateTime.now(), true));
  messages.add(Message('Ian', 'Jai pas mes lunettes', DateTime.now(), true));
  messages.add(Message('Dan', 'Le cout sera de 10 dollars par personne, on part du centreville', DateTime.now(), true));
  messages.add(Message('Ian', 'Cest parfait, merci!', DateTime.now(), false));
  messages.add(Message('Ian', 'En passant, jaime vraiment ton char', DateTime.now(), false));
  messages.add(Message('Ian', 'Il a des beau sticker de course', DateTime.now(), false));
  messages.add(Message('Dan', 'Yo, laisse moi tranquil, sinon jte kick out du carpool.', DateTime.now(), false));
  return messages;
}