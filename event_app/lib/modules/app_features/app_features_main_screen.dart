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
  State<StatefulWidget> createState() {
    return _AppFeaturesMainScreenState();
  }
}

class _AppFeaturesMainScreenState extends State<AppFeaturesMainScreen> {
  // Changer pour 0
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Déterminer le route_handler selon le current feature

    // var navigationSwitcher = () {
    //   switch (_selectedIndex) {
    //     // case 0 : router pour mailwall
    //     // case 1 : router pour messenger
    //     // case 2 : router pour ligths
    //     case 3:
    //       return router.generateGameRoute;
    //     // case 4 : return router.generateCarpoolRoute;
    //     default:
    //       return router.generateAppFeatureRoute;
    //   }
    // }();

    return Scaffold(
      backgroundColor: primary_background,
      body:
          // WillPopScope(
          //   onWillPop: () async {
          //     if (Utils.appFeaturesNav.currentState!.canPop()) {
          //       Utils.appFeaturesNav.currentState!.pop();
          //       return false;
          //     }
          //     return true;
          //   },
          //   child:
          Row(
        children: <Widget>[
          // ==========================================
          // ============= MAIN CONTENT ===============
          // ==========================================
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: <Widget>[
              Navigator(
                key: Utils.mainWallNav,
                initialRoute: mainWallRoute,
                onGenerateRoute: router.generateMainWallRoute,
              ),
              Navigator(
                key: Utils.messengerNav,
                initialRoute: messengerLandingScreenRoute,
                onGenerateRoute: router.generateMessengerRoute,
              ),
              Navigator(
                key: Utils.lightEffectsNav,
                initialRoute: lightEffectsRoute,
                onGenerateRoute: router.generateLightEffectsRoute,
              ),
              Navigator(
                key: Utils.crowdGameNav,
                initialRoute: gameRoomListRoute,
                onGenerateRoute: router.generateGameRoute,
              ),
/*                 Navigator(
                  key: Utils.carpoolNav,
                  initialRoute: carPoolListRoute,
                  onGenerateRoute: router.generateCarpoolRoute,
                ), */
            ]),
//
            // child: Navigator(
            //   key: Utils.appFeaturesNav,
            //   initialRoute: gameRoomListRoute,
            //   onGenerateRoute:
            //       navigationSwitcher, // ou feature_router.generateAppFeatureRoute si on met toutes les routes à la meme place
            // ),
//
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
      // ),   WillPopScore
    );
  }
}
