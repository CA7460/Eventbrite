import 'dart:async';
import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/modules/app_features/crowd_games/models/player.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';
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

Future<String> getRoomStatus(String roomId) async {
  var response = await getRoomStatusFromDatabase(roomId);
  if (response[0] == "OK" && response.length > 1) {
    if (response[1].toString().contains('status')) {
      return response[1]['status'];
    }
  }
  return GameStatus.pending;
}

void removeMeAsPlayer() async {
  await removeMeFromPlayerManager();
}

class GameRoomScreen extends StatefulWidget {
  final GameRoom gameroom;
  const GameRoomScreen({Key? key, required this.gameroom}) : super(key: key);

  @override
  _GameRoomScreenState createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  late Future<List<Player>> _playerListFuture;
  String roomStatus = GameStatus.pending;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
    _playerListFuture = getPlayers(widget.gameroom.gameroomid);
    //roomStatus = getRoomStatus(widget.gameroom.gameroomid);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 2);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        getRoomStatus(widget.gameroom.gameroomid).then((String result) {
          roomStatus = result;
        });
        setState(() {
          _playerListFuture = getPlayers(widget.gameroom.gameroomid);
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameroom = widget.gameroom;
    final gameHost = gameroom.hostName;
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.15;
    final centerLayoutHeight = screenSize.height * 0.50;
    final centerLayoutHeight2 = screenSize.height * 0.10;
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              height: centerLayoutHeight,
              child: FutureBuilder<List<Player>>(
                  future: _playerListFuture,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Player>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      List<Player> players = snapshot.data!;

                      return GameRoomWidget(
                        players: players,
                        capacity: gameroom.capacity,
                        gameStatus: roomStatus == GameStatus.ongoing ? roomStatus : gameroom.roomStatus,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: primary_blue),
                      );
                    }
                  }),
            ),
            Container(
                height: centerLayoutHeight2,
                child: Text(roomStatus != GameStatus.ongoing ? "Waiting for host to start..." : "Game has started!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
            Container(
              height: bottomLayoutHeight,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryButton(
                      'Join game',
                      roomStatus.toString() != GameStatus.ongoing
                          ? primary_background
                          : primary_blue,
                      onPressed: () => {
                            if (roomStatus == GameStatus.ongoing)
                              {
                                _timer?.cancel(),
                                Utils.crowdGameNav.currentState!
                                    .pushReplacementNamed(joinGameRoute,
                                        arguments: widget.gameroom.gameroomid)
                                    .then((value) {
                                  removeMeAsPlayer();
                                }),
                              }
                          }),
                  PrimaryButton('Cancel', primary_blue,
                      onPressed: () => {
                            _timer?.cancel(),
                            // REMOVE USER FROM ROOM =================================================
                            // OU PLUTOT GERER CA AVEC LE THEN VALUE DE GAMELIST SCREEN POP

                            Utils.crowdGameNav.currentState!.pop()
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
