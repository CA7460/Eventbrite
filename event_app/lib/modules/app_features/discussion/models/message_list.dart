import 'dart:developer';

import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/foundation.dart';

class MessageList extends ChangeNotifier {
  List<Message> messageList = [];
  String? convoId;

  MessageList() {
    loadMessages(convoId);
  }

  Future<void> loadMessages(String? convoId) async {
    if (convoId != null) {
      messageList = await getMessagesForConversation(convoId);
      messageList.sort((a,b) => a.sentAt.compareTo(b.sentAt));
    }
    notifyListeners();
  }

  void addMessage(Message message) {
    messageList.add(message);
    notifyListeners();
  }
}