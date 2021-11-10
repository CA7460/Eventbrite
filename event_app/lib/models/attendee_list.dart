import 'package:event_app/models/user.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/foundation.dart';

class AttendeeList extends ChangeNotifier {
  List<User> attendees = [];
  String? eventId;

  AttendeeList() {
    loadAttendees(eventId);
  }

  Future<void> loadAttendees(String? eventId) async {
    if (eventId != null) {
      attendees = await getAttendees(eventId);
    }
    notifyListeners();
  }
}