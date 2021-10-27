import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
// import 'package:event_app/utils/services/rest_api_service.dart';
// import 'package:event_app/widgets/primary_button_widget.dart';
// import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom_list_item.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/config/routes/routes_handler.dart' as router;


class AppFeaturesMainScreen extends StatefulWidget {
  const AppFeaturesMainScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AppFeaturesMainScreenState();
  }
}

class _AppFeaturesMainScreenState extends State<AppFeaturesMainScreen> {
  int _selectedIndex = 0;
  // var navigationSwitcher = feature_router.generateAppFeatureRoute;
  // fare un switch avec index, pour passer de d'une navigation interne d'un feature à l'autre
  // bonne idée ?? 
  var navigationSwitcher = router.generateGameRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_background,
      body: WillPopScope(
        onWillPop: () async {
          if (Utils.appFeaturesNav.currentState!.canPop()) {
            Utils.appFeaturesNav.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Row(
          children: <Widget>[
            // MAIN CONTENT, allowing to keep navigationrail state
            Expanded(
              child: Navigator(
                  key: Utils.appFeaturesNav,    
                  initialRoute: gameRoomListRoute,
                  onGenerateRoute: navigationSwitcher, // feature_router.generateAppFeatureRoute),
              ),
            ),
            // initialRoute sera changée pour main wall, premier feature, index 0
            // La initialRoute mene vers une instance de GameRoomListScreen()
            // Quand on veut changer le contenu on utilise la commande 
            // Utils.crowdGamesNav.currentState!.pushNamed(enterGameRoomRoute)
            // crowdGamesNav est une clé unique qui pointe vers ce nested navigator voir utils/utils.dart
            // utiliser pushedNamed, car pushReplacementNamed remplace la route donc on ne peut pas back dessus 

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
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.collections, color: black),
                  selectedIcon: Icon(Icons.collections, color: primary_blue),
                  label: Text(
                    'Wall',
                    style: TextStyle(
                      color: primary_blue,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.comment, color: black),
                  selectedIcon: Icon(Icons.comment, color: primary_blue),
                  label: Text(
                    'Chat',
                    style: TextStyle(
                      color: primary_blue,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.flare, color: black),
                  selectedIcon: Icon(Icons.flare, color: primary_blue),
                  label: Text(
                    'Lights',
                    style: TextStyle(
                      color: primary_blue,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.games, color: black),
                  selectedIcon: Icon(Icons.games, color: primary_blue),
                  label: Text(
                    'games',
                    style: TextStyle(
                      color: primary_blue,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.directions_car, color: black),
                  selectedIcon: Icon(Icons.directions_car, color: primary_blue),
                  label: Text(
                    'Carpool',
                    style: TextStyle(
                      color: primary_blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
