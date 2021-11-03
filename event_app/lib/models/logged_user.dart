import 'package:event_app/models/user.dart';
import 'package:flutter/material.dart';

class LoggedUser extends ChangeNotifier {
  User? user;

  LoggedUser();

  logUser(User? user){
    this.user = user;
    notifyListeners();
  }
}