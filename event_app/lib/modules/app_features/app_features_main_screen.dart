import 'package:event_app/models/eventmod.dart';
import 'package:flutter/material.dart';
import 'package:event_app/widgets/navigationrail_item_widget.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/config/routes/routes_handler.dart' as router;

class AppFeaturesMainScreen extends StatefulWidget {
  final EventMod event;

  const AppFeaturesMainScreen({Key? key, required this.event})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppFeaturesMainScreenState();
}

class _AppFeaturesMainScreenState extends State<AppFeaturesMainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // POUR AVOIR ACCÈES À L'EVENT: widget.event
    // POUR LE PASSER A VOTRR SCREEN: voir carpool lignes 70 à 76

    return Scaffold(
      backgroundColor: primary_background,
      body: Row(
        children: <Widget>[
          // ==========================================
          // ============= MAIN CONTENT ===============
          // ==========================================
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: <Widget>[
              WillPopScope(
                onWillPop: () async {
                  if (Utils.mainWallNav.currentState!.canPop()) {
                    Utils.mainWallNav.currentState!.pop();
                    return false;
                  }
                  return true;
                },
                child: Navigator(
                  key: Utils.mainWallNav,
                  initialRoute: mainWallRoute,
                  onGenerateRoute: router.generateMainWallRoute,
                ),
              ),

              // Le feature Messenger est en commentaire pcq il reste du code à faire
              // Les icône du NavigationRail seront décallés

              // Navigator(
              //   key: Utils.messengerNav,
              //   initialRoute: messengerLandingScreenRoute,
              //   onGenerateRoute: router.generateMessengerRoute,
              // ),

              WillPopScope(
                onWillPop: () async {
                  if (Utils.lightEffectsNav.currentState!.canPop()) {
                    Utils.lightEffectsNav.currentState!.pop();
                    return false;
                  }
                  return true;
                },
                child: Navigator(
                  key: Utils.lightEffectsNav,
                  initialRoute: lightEffectsRoute,
                  onGenerateRoute: router.generateLightEffectsRoute,
                ),
              ),
              WillPopScope(
                onWillPop: () async {
                  if (Utils.crowdGameNav.currentState!.canPop()) {
                    Utils.crowdGameNav.currentState!.pop();
                    return false;
                  }
                  return true;
                },
                child: Navigator(
                  key: Utils.crowdGameNav,
                  initialRoute: gameRoomListRoute,
                  onGenerateRoute: router.generateGameRoute,
                ),
              ),

              WillPopScope(
                onWillPop: () async {
                  if (Utils.carpoolNav.currentState!.canPop()) {
                    Utils.carpoolNav.currentState!.pop();
                    return false;
                  }
                  return true;
                },
                child: Navigator(
                  key: Utils.carpoolNav,
                  initialRoute: carPoolListRoute,
                  onGenerateInitialRoutes:
                      (NavigatorState navigator, String initialRouteName) {
                    return [
                      navigator.widget.onGenerateRoute!(RouteSettings(
                          name: carPoolListRoute, arguments: widget.event))!,
                    ];
                  },
                  onGenerateRoute: router.generateCarPoolRoute,
                ),
              ),
            ]),
          ),

          // ==========================================
          // ============== NAVIGATION ================
          // ==========================================
          NavigationRail(
            groupAlignment: -0.5, // De -1.0=top à 1=bottom
            backgroundColor: navigationrail_background,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              navigationRailItem(AppFeature.mainWall),
              navigationRailItem(AppFeature.messenger),
              navigationRailItem(AppFeature.lights),
              navigationRailItem(AppFeature.games),
              navigationRailItem(AppFeature.carpool)
            ],
          ),
        ],
      ),
    );
  }
}
