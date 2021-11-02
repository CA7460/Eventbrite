import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/models/player.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/utils/services/rest_api_service.dart';

Future<List<Player>> getPlayers(String roomId) async {
  var response = await getPlayersInGameRoomFromDatabase(roomId);
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((player) => Player.fromJson(player)).toList();
  }
  return <Player>[];
}

class GameRoomScreen extends StatefulWidget {
  final GameRoom gameroom;
  const GameRoomScreen({Key? key, required this.gameroom}) : super(key: key);

  @override
  _GameRoomScreenState createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final gameroom = widget.gameroom;
    final gameroomId = gameroom.gameroomid;
    final gameHost = gameroom.hostName;
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.15;
    final centerLayoutHeight = screenSize.height * 0.60;
    final bottomLayoutHeight = screenSize.height * 0.25;

    return Container(
      color: primary_background,
      child: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: topLayoutHeight,
              child: Text(
                gameHost + "'s game",
                style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:50),
              alignment: Alignment.topCenter,
              height: centerLayoutHeight,
              child: FutureBuilder<List<Player>>(
                  future: getPlayers(gameroomId),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Player>> snapshot,
                  ) {          
                    if (snapshot.hasData) {
                      List<Player> players = snapshot.data!;
                      return GameRoomWidget(players:players, capacity:gameroom.capacity, gameStatus: gameroom.roomStatus,);
                    } 
                    else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Container(
              height: bottomLayoutHeight,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryButton('Start', primary_blue,
                      onPressed: () => {
                            // Utils.appFeaturesNav
                            //     .currentState!
                            //     .pushNamed(
                            //         scoreboardRoute)
                          }),
                  PrimaryButton('Cancel', primary_blue,
                      onPressed: () => {
                       
                        Utils.appFeaturesNav.currentState!.pop()
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
