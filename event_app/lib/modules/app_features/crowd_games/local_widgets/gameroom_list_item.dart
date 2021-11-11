import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/join_game_button.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';

void addMeAsPlayer(String gameroomid) async {
  final String userMail = await getUser();
  print('adding unser to player manager');
  addPlayerToPlayerManager(userMail, gameroomid);
}

class GameRoomListItem extends StatefulWidget {
  final Function removeMeAsPlayer;
  final List<GameRoom> gamerooms;
  final int index;
  const GameRoomListItem(this.removeMeAsPlayer, this.gamerooms, this.index,
      {Key? key})
      : super(key: key);

  @override
  State<GameRoomListItem> createState() => _GameRoomListItemState();
}

class _GameRoomListItemState extends State<GameRoomListItem> {
  @override
  Widget build(BuildContext context) {
    void joinGame(GameRoom gameRoom) {
      if (gameRoom.playerCount < gameRoom.capacity) {
        if (gameRoom.progress < 100) {
          // VÉRIFIER SI C'EST LE ROOM CREATOR
          addMeAsPlayer(gameRoom.gameroomid);
          gameRoom.roomStatus == GameStatus.pending
              ? Utils.appFeaturesNav.currentState!
                  .pushNamed(enterGameRoomRoute, arguments: gameRoom)
                  .then((value) {
                  print(
                      'returning to gamelist after room entering gameroom list item line 42');
                  //widget.removeMeAsPlayer();
                })
              : Utils.appFeaturesNav.currentState!
                  .pushNamed(joinGameRoute, arguments: gameRoom.gameroomid)
                  .then((value) {
                  print(
                      'returning to gamelist after joining game gameroom list item line 48');
                  //widget.removeMeAsPlayer();
                });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(EventSnackBar(
              'Game just endend !  Try to join another game',
              SnackBarType.warning));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(EventSnackBar(
            'Game is full !  Try to join another game', SnackBarType.warning));
      }
    }

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
              child: Text(widget.gamerooms[widget.index].hostName + "'s game",
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
                            "Players ${widget.gamerooms[widget.index].playerCount}/${widget.gamerooms[widget.index].capacity}",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Text(
                            "Progress ${widget.gamerooms[widget.index].progress}%",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      //SizedBox(height: 15),
                      LinearPercentIndicator(
                        width: 115.0,
                        lineHeight: 3.0,
                        percent:
                            (widget.gamerooms[widget.index].progress) / 100,
                        backgroundColor: textbox_background,
                        progressColor: primary_green,
                      ),
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
                              joinGame(widget.gamerooms[widget.index])),
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
