import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/modules/app_features/crowd_games/models/player.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/config/routes/routes.dart';

Future<List<Player>> createGameRoom() async {
  final String userMail = await getUser();
  final userResponse = await getUserDetailsFromDatabase(userMail);

  if (userResponse[0] == "OK" && userResponse.length > 1) {
    final User gameCreator = User.fromJson(userResponse[1]);
    // userResponse[1].map((user) => User.fromJson(user));

    print(gameCreator.userid);

    final gameRoomResponse = await createGameRoomInDatabase(gameCreator.userid);
    if (gameRoomResponse[0] == "OK" && gameRoomResponse.length > 1) {
      gameRoomResponse.removeAt(0);
      print(gameRoomResponse);
      return gameRoomResponse.map((player) => Player.fromJson(player)).toList();
    }
  }
  return <Player>[];
}

Future<void> deleteGameRoom(String roomid) async {
  final deleteResponse = await deleteGameRoomFromDatabase(roomid);
  if (deleteResponse[0] == "OK") {
    print(deleteResponse);
  }
}

class CreateGameScreen extends StatefulWidget {
  const CreateGameScreen({Key? key}) : super(key: key);

  @override
  _CreateGameScreenState createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.15;
    final centerLayoutHeight = screenSize.height * 0.60;
    final bottomLayoutHeight = screenSize.height * 0.25;

    String roomid = "";
    return Container(
      color: primary_background,
      child: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: topLayoutHeight,
              child: Text(
                "New Game",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              height: centerLayoutHeight,
              child: FutureBuilder<List<Player>>(
                  future: createGameRoom(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Player>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      List<Player> players = snapshot.data!;
                      roomid = players[0].roomId;
                      return GameRoomWidget(
                        players: players,
                        capacity: GameRoom.playerCapacity,
                        gameStatus: GameStatus.pending,
                      );
                    } else {
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
                            Utils.appFeaturesNav.currentState!
                                .pushNamed(startNewGameRoute, arguments: roomid)
                          }),
                  PrimaryButton('Cancel', primary_blue,
                      onPressed: () =>

                          // AJOUTER UNE REQUETE SQL POUR DELETE LA ROW
                          {
                            deleteGameRoom(roomid),
                            Utils.appFeaturesNav.currentState!.pop('Test')
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
