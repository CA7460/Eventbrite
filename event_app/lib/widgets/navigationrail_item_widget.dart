import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';

enum AppFeature { mainWall, messenger, lights, games, carpool }

List<dynamic> getNavigationRailItemContent(AppFeature feature) {
  List<dynamic> nriContent = <dynamic>[];
  switch (feature) {
    case AppFeature.mainWall:
      nriContent.add(Icons.collections);nriContent.add('Wall');
      break;
    case AppFeature.messenger:
      nriContent.add(Icons.comment);nriContent.add('Chat');
      break;
    case AppFeature.lights:
      nriContent.add(Icons.flare);nriContent.add('Lights');
      break;
    case AppFeature.games:
      nriContent.add(Icons.games);nriContent.add('Games');
      break;
    case AppFeature.carpool:
      nriContent.add(Icons.directions_car);nriContent.add('Carpool');
      break;
  }
  return nriContent;
}

NavigationRailDestination navigationRailItem(AppFeature feature) {
  List<dynamic> nriContent = getNavigationRailItemContent(feature);
  return NavigationRailDestination(
    icon: Icon(nriContent[0], color: black),
    selectedIcon: Icon(nriContent[0], color: primary_blue),
    label: Text(
      nriContent[1],
      style: TextStyle(
        color: primary_blue,
      ),
    ),
  );
}
