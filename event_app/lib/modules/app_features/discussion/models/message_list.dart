import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:flutter_application_1/services/messenger_helper.dart';

class MessageList extends ChangeNotifier {
  List<Message> messageList = [];

  MessageList() {
    loadMessages();
  }

  Future<void> loadMessages() async {
    messageList = await getMessagesForConversation('Dan');
    notifyListeners();
  }

  void addMessage(Message message) {
    messageList.add(message);
    notifyListeners();
  }
}