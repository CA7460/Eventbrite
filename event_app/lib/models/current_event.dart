import 'package:event_app/models/eventmod.dart';
import 'package:flutter/material.dart';

class CurrentEvent extends ChangeNotifier {
  EventMod? event;

  CurrentEvent();

  makeCurrentEvent(EventMod? event){
    this.event = event;
    notifyListeners();
  }
}