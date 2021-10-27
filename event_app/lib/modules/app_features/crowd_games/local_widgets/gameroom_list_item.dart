import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/join_game_button.dart';
import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';

void joinGame(String roomId) {
  print(roomId);
}

class GameRoomListItem extends StatelessWidget {
  final List<GameRoom> gamerooms;
  final int index;
  const GameRoomListItem(this.gamerooms, this.index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(24, 6, 32, 0),
      color: primary_background,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
              child: Text(gamerooms[index].hostName + "'s game",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 3),
                        child: Text(
                            "Players ${gamerooms[index].playerCount}/${gamerooms[index].capacity}",
                            style: TextStyle(color: primary_red)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 3),
                        child: Text("Progress ${gamerooms[index].progress}%",
                            style: TextStyle(color: primary_red)),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 15,
                      ),

                      JoinGameButton(
                          onPressed: () =>
                              joinGame(gamerooms[index].gameroomid)),
                      // Text(
                      //   'Join Game',
                      //   style: TextStyle(color: primary_green),
                      // ),
                    ],
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
