import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom_list_item.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';

// SAVER LE STATE D'UN FEATURE QUAND ON NAVIGATE AILLEURS, ON RESUME, ON REFRESH LA LIST OU WTV
// VOIR MÉTHODE DIDPOPNEXT, Called when the top route has been popped off, and the current route shows up.

class GameRoomListScreen extends StatefulWidget {
  const GameRoomListScreen({Key? key}) : super(key: key);
  @override
  _GameRoomListScreenState createState() => _GameRoomListScreenState();
}

class _GameRoomListScreenState extends State<GameRoomListScreen> {
  //var _gameRoomListStateKey = GlobalKey<>();

  late Future<List<GameRoom>> _gameroomFuture;

  @override
  void initState() {
    super.initState();
    _gameroomFuture = getGameRooms();
  }

  void removeMeAsPlayer() async {
    await removeMeFromPlayerManager();
    //await removeMyGames();
    refreshGameRoomList();
  }

  void refreshGameRoomList() async {
    setState(() {
      _gameroomFuture = getGameRooms();
    });
  }

  Future<List<GameRoom>> getGameRooms() async {
    await removeMeFromPlayerManager();
    var response = await getGameRoomListFromDatabase();
    if (response[0] == "OK" && response.length > 1) {
      response.removeAt(0);
      return response.map((gameroom) => GameRoom.fromJson(gameroom)).toList();
    }
    return <GameRoom>[];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.55;
    final bottomLayoutHeight = screenSize.height * 0.35;
    return Center(
      child: Column(
        children: [
          Container(
            //alignment: Alignment(0.8, 0.2),
            height: topLayoutHeight,
            child: GestureDetector(
              onTap: () {
                refreshGameRoomList();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Refresh",
                    style: TextStyle(color: primary_blue),
                  ),
                  Icon(Icons.refresh, color: primary_blue),
                  SizedBox(
                    width: 25,
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: centerLayoutHeight,
            //key: _GameRoomListStateKey,
            color: primary_background,
            // child: Center(
            child: FutureBuilder<List<GameRoom>>(
                future: _gameroomFuture,
                // future: getGameRooms(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<GameRoom>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!;
                    if (items.isNotEmpty) {
                      return GameRoomListViewWidget(
                          removeMeAsPlayer, items, this);
                      // List<GameRoom> gamerooms = snapshot.data!;
                      // return GameRoomListViewWidget(gamerooms, this);

                    } else {
                      return Center(
                        child: Text("No games in progress",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primary_blue,
                      ),
                    );
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
                        {
                          Utils.crowdGameNav
                              .currentState! // pushReplacementNamed remplace la route, on ne peut pas back dessus
                              .pushNamed(createGameRoute)
                              .then((value) {
                            // removeMeAsPlayer();
                            print(
                                'returning to game list: gameroomlist screen line 141');
                            //refreshGameRoomList();
                          }) // pushNamed permet de pop()
                        }),
                PrimaryButton('Scoreboard', primary_blue,
                    onPressed: () => {
                          Utils.crowdGameNav.currentState!
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
  final Function removeMeAsPlayer;
  final List<GameRoom> gamerooms;
  final dynamic _listViewStateInstance;

  const GameRoomListViewWidget(
      this.removeMeAsPlayer, this.gamerooms, this._listViewStateInstance,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: gamerooms.isEmpty
          ? emptyList()
          : //RefreshIndicator(   // Pour les scrollable, permet de tjrs avoir une liste à jour
          //child:
          ListView.builder(
              itemCount: gamerooms.length,
              //itemBuilder: listBuilder,
              itemBuilder: (context, index) {
                return GameRoomListItem(removeMeAsPlayer, gamerooms, index);
              }),
      //onRefresh:
      //refreshGameRoomList(), // called when the user pulls the list down enough to trigger this event
      //),
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
}
