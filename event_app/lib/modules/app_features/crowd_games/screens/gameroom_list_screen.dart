import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom_list_item.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';

// SAVER LE STATE D'UN FEATURE QUAND ON NAVIGATE AILLEURS, ON RESUME, ON REFRESH LA LIST OU WTV

Future<List<GameRoom>> getGameRooms() async {
  var response = await getGameRoomListFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((gameroom) => GameRoom.fromJson(gameroom)).toList();
  }
  return <GameRoom>[];
}

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
                          Utils.appFeaturesNav
                              .currentState! // pushReplacementNamed remplace la route, on ne peut pas back dessus
                              .pushNamed(
                                  scoreboardRoute) // pushNamed permet de pop()
                          //  AJOUTER UNE NOUVELLE ROUTE POUR CREATE GAME
                        }),
                PrimaryButton('Scoreboard', primary_blue,
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
}
