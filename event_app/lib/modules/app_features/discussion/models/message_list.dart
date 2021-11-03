import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/repositories/messenger_helper.dart';
import 'package:flutter/foundation.dart';

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