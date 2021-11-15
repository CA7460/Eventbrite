import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamecount.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';
import 'package:event_app/config/routes/routes.dart';

class LoadingScreen extends StatefulWidget {
  final String roomid;
  const LoadingScreen({required this.roomid, Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late String _crowdGameId;

  @override
  void initState() {
    super.initState();
    createCrowdGame();
    updateRoomStatus(widget.roomid, GameStatus.ongoing);
  }

  void removeMeAsPlayer() async {
    await removeMeFromPlayerManager();
  }

  enterOngoingGame() {
    Utils.crowdGameNav.currentState!
        .pushReplacementNamed(joinGameRoute, arguments: widget.roomid)
        .then((value) {
      removeMeAsPlayer();
    });
  }

  Future<void> createCrowdGame() async {
    List<GameCount> gameCounts = await getGameCounts();

    CrowdGame localCrowdGame =
        CrowdGame.composeCrowdGame(widget.roomid, gameCounts);

    // Mettre un starting time à la premiere question!?
    // localCrowdGame.gameManagers[0].startTime = DateTime.now();

    // Update le status une game à la fois?
    // localCrowdGame.gameManagers[0].gameStatus = GameStatus.ongoing;
    CrowdGame completeCrowdGame = await postLocalCrowdGame(localCrowdGame);

    _crowdGameId = completeCrowdGame.crowdGameId;

    await postLocalGameManagers(_crowdGameId, localCrowdGame.gameManagers);

    await updateGameManagersStatusToOngoing(_crowdGameId, GameStatus.ongoing);

    enterOngoingGame();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primary_blue,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Loading...', style: TextStyle(color: primary_blue)),
        ],
      ),
    );
  }
}
