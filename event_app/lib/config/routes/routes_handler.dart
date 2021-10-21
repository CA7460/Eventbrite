import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/modules/event_manager/screens/event_manager_screen.dart';
import 'package:event_app/modules/login/screens/login_screen.dart';
import 'package:event_app/modules/login/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeScreenRoute:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case eventManagerScreenRoute:
      return MaterialPageRoute(builder: (context) => EventManagerScreen());
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}
