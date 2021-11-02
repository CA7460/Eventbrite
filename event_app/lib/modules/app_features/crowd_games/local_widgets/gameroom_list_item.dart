import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/join_game_button.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';

class GameRoomListItem extends StatelessWidget {
  final Function refreshGameRoomList;
  final List<GameRoom> gamerooms;
  final int index;
  const GameRoomListItem(this.refreshGameRoomList, this.gamerooms, this.index,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
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
                            style: TextStyle(color: Colors.white70)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 3),
                        child: Text("Progress ${gamerooms[index].progress}%",
                            style: TextStyle(color: Colors.white70)),
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
                      // Bouton déja formatté, fonction onPressed appelle le navigateur
                      // En spécifiant la route à prendre et les arguments (paramètres)
                      // Ici je passe un array de String
                      JoinGameButton(
                          onPressed: () => Utils.appFeaturesNav.currentState!
                                  .pushNamed(enterGameRoomRoute,
                                      arguments: gamerooms[index])
                                  .then((value) {
                                refreshGameRoomList();
                              })),
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
