import 'dart:developer';

import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/foundation.dart';

class ConversationList extends ChangeNotifier {
  List<Conversation> convoList = [];
  String? eventId;
  String? userId;

  ConversationList() {
    loadConversations(eventId, userId);
  }

  Future<void> loadConversations(String? userMail, String? eventId) async {
    if (eventId != null && userId != null) {
      convoList = await getConversations(userMail, eventId);
      convoList.sort((a,b) => a.updatedAt.compareTo(b.updatedAt));
    }
    notifyListeners();
  }

  void addConversation(Conversation conversation) {
    convoList.add(conversation);
    notifyListeners();
  }
}