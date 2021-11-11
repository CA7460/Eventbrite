import 'dart:async';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/scoredialog.dart';
import 'package:event_app/modules/app_features/crowd_games/models/score.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/actionchallenge_card.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/photochallenge_card.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/quiz_card.dart';
import 'package:event_app/modules/app_features/crowd_games/models/action_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/photo_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/quiz.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';
import 'package:flutter/rendering.dart';

class OngoingGameScreen extends StatefulWidget {
  final String roomid;
  const OngoingGameScreen({Key? key, required this.roomid}) : super(key: key);

  @override
  _OngoingGameScreenState createState() => _OngoingGameScreenState();
}

class _OngoingGameScreenState extends State<OngoingGameScreen> {
  final ScrollController _scrollController = ScrollController();

  late Future<List<Game>> _gameSetFuture;
  late List<GameScore> scores;
  late int startingStatementIndex;
  late int alreadyPlayedGames;
  String inGameScoreboardTxt = "";
  int statementIndex = 0;
  int currentScore = 0;
  bool gameHasStarted = false;

  Future<List<Game>> getGameSet(String roomid) async {
    List<GameManager> gameManagers = await getGameManagers(roomid);
    List<Game> gameSet = await composeGameSet(gameManagers);
    updateInGameScoreboard();
    for (int i = 0; i < gameManagers.length; i++) {
      if (gameManagers[i].gameStatus == GameStatus.ongoing) {
        startingStatementIndex = i;
        alreadyPlayedGames = i;
        statementIndex = startingStatementIndex;
        break;
      }
    }
    return gameSet;
  }

  @override
  void initState() {
    super.initState();
    _gameSetFuture = getGameSet(widget.roomid);
    scrollTheFuckDown();
  }

  Future<void> scrollTheFuckDown() async {
    Timer(const Duration(milliseconds: 3500), () {
      _scrollToEnd();
    });
  }

  Future<void> displayCurrentGame() async {
    Timer(const Duration(milliseconds: 1000), () {
      CrowdGame.gameListKey.currentState!.insertItem(startingStatementIndex);
    });
  }

  void advanceToNextGame() async {
    updateInGameScoreboard();
    updateGameProgress(widget.roomid, statementIndex);
    updateSingleGameStatusToEnded(widget.roomid, statementIndex);
    statementIndex++;

    if (statementIndex < CrowdGame.statementCount) {
      CrowdGame.gameListKey.currentState!
          .insertItem(statementIndex); // ???? faire des tests
    } else {
      endGame();
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
  }

  void updateInGameScoreboard() async {
    inGameScoreboardTxt = "";
    scores = await getPlayerScores(widget.roomid);
    for (GameScore s in scores) {
      inGameScoreboardTxt += "${s.player}'s score ${s.score}\n";
    }
  }

  scrollToCurrentStatement() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  _scrollToEnd() async {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
    }
  }

  void getPoints(int points) {
    setState(() {
      currentScore += points;
      updateScoreBoard(currentScore);
    });
  }

  void endGame() async {
    await updateGlobalScoreboard(currentScore);
    scores = await getPlayerScores(widget.roomid);

    showScoreDialog(scores);
  }

  void showScoreDialog(List<GameScore> scores) async {
    int highScore = 0;
    late GameScore winner = scores[0];
    String scoreBoardTxt = "";
    String userMail = await getUser();

    for (GameScore s in scores) {
      if (s.score > highScore) {
        highScore = s.score;
        winner = s;
      }
      scoreBoardTxt += "${s.player}'s score ${s.score}\n";
    }

    showDialog(
      context: context,
      builder: (_) => CustomDialogBox(
          title: winner.mail == userMail ? "You won the game!" : "Game over!",
          descriptions:
              "$currentScore points been added to your scoreboard\n\n\n$scoreBoardTxt",
          btn1text: "Scoreboard",
          btn2text: "Quit"),
    );
    updateRoomStatus(widget.roomid, GameStatus.ended);
  }

  // =========================================================================================

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.75;
    final bottomLayoutHeight = screenSize.height * 0.15;

    return Center(
      child: Column(
        children: [
          // Container(
          //   height: topLayoutHeight,
          //   alignment: Alignment.bottomRight,
          //   child: Row(
          //     children: [
          //       SizedBox(width: screenSize.width * 0.5),
          //       Padding(
          //         padding: const EdgeInsets.all(20),
          //         child: FlatButton(
          //           child: Text('Quit',
          //               style: TextStyle(color: primary_blue, fontSize: 16)),
          //           onPressed: () {
          //             Utils.appFeaturesNav.currentState!.pop();
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            height: topLayoutHeight,
            child: GestureDetector(
              onTap: () {
                Utils.appFeaturesNav.currentState!.pop();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Quit ",
                    style: TextStyle(color: primary_blue),
                  ),
                  Icon(Icons.exit_to_app, color: primary_blue),
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

            child: FutureBuilder<List<Game>>(
                future: _gameSetFuture,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Game>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final games = snapshot.data!;

                    //  _scrollToEnd();

                    return AnimatedList(
                        key: CrowdGame.gameListKey,
                        controller: _scrollController,
                        initialItemCount: alreadyPlayedGames == 0
                            ? 1
                            : alreadyPlayedGames +
                                1, // +1 fonctionne un peu mais surement va planter en buildant le dernier
                        itemBuilder: (context, index, animation) {
                          // TIMERSTATE: <0 skipgame, 0 delay timerstart, >1 starttimer
                          switch (games[index].category) {
                            case 'Quiz':
                              return QuizCard(
                                games[index] as Quiz,
                                getPoints,
                                scrollToCurrentStatement,
                                advanceToNextGame,
                                timerState: startingStatementIndex - index,
                                statementNumber: index + 1,
                              );
                            case 'Challenge':
                              return ActionCard(
                                games[index] as ActionChallenge,
                                getPoints,
                                scrollToCurrentStatement,
                                advanceToNextGame,
                                timerState: startingStatementIndex - index,
                                statementNumber: index + 1,
                              );
                            default:
                              return PhotoHuntCard(
                                games[index] as PhotoChallenge,
                                getPoints,
                                scrollToCurrentStatement,
                                advanceToNextGame,
                                timerState: startingStatementIndex - index,
                                statementNumber: index + 1,
                              );
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: primary_blue),
                    );
                  }
                }),
            // ),
          ),
          Container(
            height: bottomLayoutHeight,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Score",
                        style: TextStyle(
                            color: primary_pink,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(currentScore.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      inGameScoreboardTxt,
                      style: TextStyle(
                        color: primary_pink,
                        fontSize: 13,
                      ),
                    )
                    // Text("Player 1: 50 pts",
                    //     style: TextStyle(
                    //       color: primary_pink,
                    //       fontSize: 13,
                    //     )),
                    // Text("Player 2: 200 pts",
                    //     style: TextStyle(
                    //       color: primary_pink,
                    //       fontSize: 13,
                    //     )),
                    // Text("Player 3: 150 pts",
                    //     style: TextStyle(
                    //       color: primary_pink,
                    //       fontSize: 13,
                    //     )),
                    // Text("Player 4: 50 pts",
                    //     style: TextStyle(
                    //       color: primary_pink,
                    //       fontSize: 13,
                    //     )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
