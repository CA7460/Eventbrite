import 'package:event_app/modules/app_features/crowd_games/models/player.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';

class GameRoomWidget extends StatelessWidget {
  final List<Player> players;
  final int capacity;
  final String gameStatus;

  const GameRoomWidget(
      {Key? key, required this.players, required this.capacity, required this.gameStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String playerList = "";
    String scoreList = "";

    for (Player player in players) {
      playerList += player.name + "\n";
      scoreList += player.score.toString() + " pts\n";
    }

    return Container(
      height: 212,
      child: Card(
        margin: EdgeInsets.fromLTRB(48, 6, 48, 0),
        color: textbox_background,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Players ${players.length}/$capacity",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("Score",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  Divider(color: black),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(playerList,
                            style: TextStyle(color: Colors.white70)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(scoreList,
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("Status: " + gameStatus,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primary_green)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
