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
  int _selectedIndex = 1;


  @override
  Widget build(BuildContext context) {
    // Déterminer le route_handler selon le current feature
    var navigationSwitcher = () {
      switch (_selectedIndex) {
        // case 0 : router pour mailwall
        case 1: 
          return router.generateMessengerRoute;
        // case 2 : router pour ligths
        case 3:
          return router.generateGameRoute;
        // case 4 : return router.generateCarpoolRoute;
        default:
          return router.generateAppFeatureRoute;
      }
    }();

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
            // ==========================================
            // ============= MAIN CONTENT ===============
            // ==========================================
            Expanded(
              child: Navigator(
                key: Utils.appFeaturesNav,
                initialRoute: messengerLandingScreenRoute,
                onGenerateRoute:
                    navigationSwitcher, // ou feature_router.generateAppFeatureRoute si on met toutes les routes à la meme place
              ),
            ),
            // initialRoute sera changée pour main_wall, premier feature, index 0
            // La initialRoute menera vers une instance du Screen pour le main_wall
            // Quand on veut changer le contenu ex. pour crowd games on utilise la commande
            // Utils.appFeaturesNav.currentState!.pushNamed(enterGameRoomRoute)
            // appFeaturesNav est une clé unique qui pointe vers ce nested navigator voir utils/utils.dart
            // utiliser pushedNamed, car pushReplacementNamed remplace la route donc on ne peut pas back dessus

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
      ),
    );
  }
}
