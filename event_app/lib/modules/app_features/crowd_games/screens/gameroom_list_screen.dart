import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom_list_item.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/config/routes/routes_handler.dart' as game_router;

// SAVER LE STATE D'UN FEATURE QUAND ON NAVIGATE AILLEURS, ON RESUME, ON REFRESH LA LIST OU WTV

Future<List<GameRoom>> getGameRooms() async {
  var response = await getGameRoomListFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((gameroom) => GameRoom.fromJson(gameroom)).toList();
  }
  return <GameRoom>[];
}

// class CrowdGameLandingScreen extends StatefulWidget {
//   const CrowdGameLandingScreen({Key? key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return _CrowdGameLandingScreenState();
//   }
// }

// class _CrowdGameLandingScreenState extends State<CrowdGameLandingScreen> {
//   int _selectedIndex = 3;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primary_background,
//       body: WillPopScope(
//         onWillPop: () async {
//           if (Utils.crowdGamesNav.currentState!.canPop()) {
//             Utils.crowdGamesNav.currentState!.pop();
//             return false;
//           }
//           return true;
//         },
//         child: Row(
//           children: <Widget>[
//             // MAIN CONTENT, allowing to keep navigationrail state
//             Expanded(
//               child: Navigator(
//                   key: Utils.crowdGamesNav,
//                   initialRoute: gameRoomListRoute,
//                   onGenerateRoute: game_router.generateGameRoute),
//             ),
//             // La initialRoute mene vers une instance de GameRoomListScreen()
//             // Quand on veut changer le contenu on utilise la commande 
//             // Utils.crowdGamesNav.currentState!.pushNamed(enterGameRoomRoute)
//             // crowdGamesNav est une clé unique qui pointe vers ce nested navigator voir utils/utils.dart
//             // utiliser pushedNamed, car pushReplacementNamed remplace la route donc on ne peut pas back dessus 

//             NavigationRail(
//               groupAlignment: -0.5, // De -1.0=top à 1=bottom
//               backgroundColor: navigationrail_background,
//               selectedIndex: _selectedIndex,
//               onDestinationSelected: (int index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               labelType: NavigationRailLabelType.selected,
//               destinations: const [
//                 NavigationRailDestination(
//                   icon: Icon(Icons.collections, color: black),
//                   selectedIcon: Icon(Icons.collections, color: primary_blue),
//                   label: Text(
//                     'Wall',
//                     style: TextStyle(
//                       color: primary_blue,
//                     ),
//                   ),
//                 ),
//                 NavigationRailDestination(
//                   icon: Icon(Icons.comment, color: black),
//                   selectedIcon: Icon(Icons.comment, color: primary_blue),
//                   label: Text(
//                     'Chat',
//                     style: TextStyle(
//                       color: primary_blue,
//                     ),
//                   ),
//                 ),
//                 NavigationRailDestination(
//                   icon: Icon(Icons.flare, color: black),
//                   selectedIcon: Icon(Icons.flare, color: primary_blue),
//                   label: Text(
//                     'Lights',
//                     style: TextStyle(
//                       color: primary_blue,
//                     ),
//                   ),
//                 ),
//                 NavigationRailDestination(
//                   icon: Icon(Icons.games, color: black),
//                   selectedIcon: Icon(Icons.games, color: primary_blue),
//                   label: Text(
//                     'games',
//                     style: TextStyle(
//                       color: primary_blue,
//                     ),
//                   ),
//                 ),
//                 NavigationRailDestination(
//                   icon: Icon(Icons.directions_car, color: black),
//                   selectedIcon: Icon(Icons.directions_car, color: primary_blue),
//                   label: Text(
//                     'Carpool',
//                     style: TextStyle(
//                       color: primary_blue,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class GameRoomListScreen extends StatefulWidget {
  const GameRoomListScreen({Key? key}) : super(key: key);
  @override
  _GameRoomListScreenState createState() => _GameRoomListScreenState();
}

class _GameRoomListScreenState extends State<GameRoomListScreen> {
  //var _gameRoomListStateKey = GlobalKey<>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.65;
    final bottomLayoutHeight = screenSize.height * 0.25;
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: topLayoutHeight,
            child: GestureDetector(
                onTap: () {
                  print("refresh btn pressed");
                },
                child: Text("Refresh list",
                    style: TextStyle(color: primary_blue))),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: centerLayoutHeight,
            //key: _GameRoomListStateKey,
            color: primary_background,
            // child: Center(
            child: FutureBuilder<List<GameRoom>>(
                future: getGameRooms(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<GameRoom>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    List<GameRoom> gamerooms = snapshot.data!;
                    return GameRoomListViewWidget(gamerooms, this);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            // ),
          ),
          Container(
            height: bottomLayoutHeight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryButton('Create game', primary_blue,
                    onPressed: () =>
                        // {Navigator.pushNamed(context, enterGameRoomRoute)}),
                        {
                          Utils.appFeaturesNav.currentState!  // pushReplacementNamed remplace la route, on ne peut pas back dessus
                              .pushNamed(enterGameRoomRoute)  // pushNamed permet de pop()
                        }), 
                PrimaryButton('Scoreboard', primary_blue,     // Faudrait voir si on fait plusieurs navigator, un pour chaque feature? 
                    onPressed: () => {
                          Utils.appFeaturesNav.currentState!
                              .pushNamed(scoreboardRoute)
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameRoomListViewWidget extends StatelessWidget {
  final List<GameRoom> gamerooms;
  final dynamic _listViewStateInstance;

  const GameRoomListViewWidget(this.gamerooms, this._listViewStateInstance,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: gamerooms.isEmpty
          ? emptyList()
          : ListView.builder(
              itemCount: gamerooms.length,
              //itemBuilder: listBuilder,
              itemBuilder: (context, index) {
                return GameRoomListItem(gamerooms, index);
              }),
    );
  }

  Widget emptyList() {
    return Text(
      'No games availble',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  // Widget listBuilder(BuildContext context, int index) {
  //   return GameRoomListItem(gamerooms, index);

  // return Container(
  //   child: Padding(
  //     padding: EdgeInsets.all(10.0),
  //     child: Text(
  //       "room id : " +
  //           gamerooms[index].gameroomid +
  //           "\nCreated : " +
  //           gamerooms[index].createdAt.toString() +
  //           "\nHost id : " +
  //           gamerooms[index].userid +
  //           "\nRoom Capacity : " +
  //           gamerooms[index].capacity.toString() +
  //           "\nPlayers in room : " +
  //           gamerooms[index].playerCount.toString() +
  //           "\nGame Status : " +
  //           gamerooms[index].roomStatus +
  //           "\nGame progress : " +
  //           gamerooms[index].progress.toString() +
  //           "%",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ),
  // );
  // }

}
