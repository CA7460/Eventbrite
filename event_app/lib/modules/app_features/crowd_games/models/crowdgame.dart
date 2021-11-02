import 'dart:math';
// import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamecount.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gametype.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/photo_challenge.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/quiz.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/action_challenge.dart';

class CrowdGame {
  static const int statementCount = 10;

  String _crowdGameId = "";
  String gameroomid;
  DateTime createdAt = DateTime.now();
  List<GameManager> gameManagers;
  int currentGamePos = 1;
  String crowdGameStatus = GameStatus.ongoing;
  // List<Game> games;
  
  String get crowdGameId => _crowdGameId;

  set crowdGameId(String id) {
    _crowdGameId = id;
  }

  // scoreboard??
  CrowdGame(this.gameroomid, this.gameManagers);

  factory CrowdGame.composeCrowdGame(String id, List<GameCount> gameCounts) {
    List<GameManager> gameManagers = <GameManager>[];

    for (int i = 0; i < statementCount; i++) {
      int randomGameType = Random().nextInt(3);

      switch (randomGameType) {
        case GameType.quiz:
          gameManagers.add(GameManager(
              gameCategory: GameType.quiz,
              gameId: 1 + Random().nextInt((gameCounts[0].quizCount))));
          break;
        case GameType.photoChallenge:
          gameManagers.add(GameManager(
              gameCategory: GameType.photoChallenge,
              gameId:
                  1 + Random().nextInt((gameCounts[0].photoChallengeCount))));
          break;
        case GameType.actionChallenge:
          gameManagers.add(GameManager(
              gameCategory: GameType.actionChallenge,
              gameId:
                  1 + Random().nextInt((gameCounts[0].actionChallengeCount))));
          break;
      }
    }
    return CrowdGame(id, gameManagers);
  }

  CrowdGame.fromJson(Map<String, dynamic> json)
      : _crowdGameId = json['crowdgameid'],
        gameroomid = json['gameroomid'],
        createdAt = DateTime.parse(json['createdAt']),
        gameManagers = <GameManager>[],
        currentGamePos = json['currentgamepos'],
        crowdGameStatus = json['status'];

  // factory CrowdGame.composeCrowdGame(
  //     List<Quiz> quizzes,
  //     List<PhotoChallenge> photoChallenges,
  //     List<ActionChallenge> actionChallenges) {
  //   List<Game> games = <Game>[];

  //   for (int i = 0; i < gameCount; i++) {
  //     int randomGameType = Random().nextInt(3);
  //     print(randomGameType.toString());
  //     switch (randomGameType) {
  //       case GameType.quiz:
  //         games.add(quizzes[Random().nextInt((quizzes.length))]);
  //         break;
  //       case GameType.photoChallenge:
  //         games.add(photoChallenges[Random().nextInt((photoChallenges.length))]);
  //         break;
  //       case GameType.actionChallenge:
  //         games.add(actionChallenges[Random().nextInt((actionChallenges.length))]);
  //         break;
  //     }
  //   }
  //   return CrowdGame("", games);
  // }

}
