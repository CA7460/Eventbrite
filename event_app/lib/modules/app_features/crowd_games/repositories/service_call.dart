import 'package:event_app/modules/app_features/crowd_games/models/action_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamecount.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gametype.dart';
import 'package:event_app/modules/app_features/crowd_games/models/photo_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/quiz.dart';
import 'package:event_app/modules/app_features/crowd_games/models/score.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/services/rest_api_service.dart';

void addPlayerToPlayerManager(String userMail, String gameroomid) async {
  var response =
      await addPlayerToPlayerManagerInDatabase(userMail, gameroomid, score: 0);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1]);
  } else {
    // ERREUR POUR JOIN GAME;
  }
}

Future<List<GameManager>> getGameManagers(String roomid) async {
  var managerResponse = await getManagersFromDatabase(roomid);

  if (managerResponse[0] == "OK" && managerResponse.length > 1) {
    managerResponse.removeAt(0);
    return managerResponse.map((e) => GameManager.fromJson(e)).toList();
  }
  return <GameManager>[];
}

// Getters for each game categories =========================================================
Future<List<Quiz>> getQuizList() async {
  var response = await getQuizzesFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => Quiz.fromJson(e)).toList();
  }
  return <Quiz>[];
}

Future<List<PhotoChallenge>> getPhotoChallengeList() async {
  var response = await getPhotoChallengesFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => PhotoChallenge.fromJson(e)).toList();
  }
  return <PhotoChallenge>[];
}

Future<List<ActionChallenge>> getActionChallengeList() async {
  var response = await getActionChallengesFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => ActionChallenge.fromJson(e)).toList();
  }
  return <ActionChallenge>[];
}

// Create a final GameSet with gamemanager data ============================================
Future<List<Game>> composeGameSet(List<GameManager> gameManagers) async {
  List<Quiz> quizzes = await getQuizList();
  List<PhotoChallenge> photoChallenges = await getPhotoChallengeList();
  List<ActionChallenge> actionChallenges = await getActionChallengeList();

  List<Game> gameSet = <Game>[];

  for (GameManager gm in gameManagers) {
    switch (gm.gameCategory) {
      case GameType.quiz:
        gameSet.add(quizzes[gm.gameId - 1]);
        break;
      case GameType.photoChallenge:
        gameSet.add(photoChallenges[gm.gameId - 1]);
        break;
      case GameType.actionChallenge:
        gameSet.add(actionChallenges[gm.gameId - 1]);
        break;
    }
  }
  return gameSet;
}

// Update requests      // VOIR GAME SCREEN POUR DIFFÉRENCES  roomid etc.

void updateGameProgress(String roomid, int index) async {
  int progress = (index + 1) * 10;
  var response = await updateGameProgressInDatabase(roomid, progress);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1]);
  } else {
    // _ongoingCrowdGame = false;
  }
}

void updateSingleGameStatusToEnded(String roomid, int index) async {
  int stmt = index + 1;
  var response =
      await updateSingleGameStatusInDatabase(roomid, stmt, GameStatus.ended);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1]);
  } else {
    // _ongoingCrowdGame = false;
  }
}

void updateRoomStatus(String roomid, String status) async {
  var response = await updateRoomStatusInDatabase(roomid, status);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1]);
  } else {
    // _ongoingCrowdGame = false;
  }
}

// GAME CREATION PROCESS

// Count how many games of each categories
Future<List<GameCount>> getGameCounts() async {
  var response = await getGameCountsFromDatabase();
  print('gamecount stack');

  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => GameCount.fromJson(e)).toList();
  }
  return <GameCount>[];
}

// insert data in database and return final
Future<CrowdGame> postLocalCrowdGame(CrowdGame localCrowdGame) async {
  var response = await addCrowdGameInDatabase(localCrowdGame);
  print('create crowdgame stack');
  if (response[0] == "OK" && response.length > 1) {
    //response.removeAt(0);
    return CrowdGame.fromJson(response[1]);
  }
  return CrowdGame("", <GameManager>[]);
}

Future<void> postLocalGameManagers(
    String crowdGameId, List<GameManager> gameManagers) async {
  var response = await addGameManagersInDatabase(crowdGameId, gameManagers);
  print('create gamemanager stack');
  if (response[0] == "OK" && response.length > 1) {
    print(response[1].toString());
  } else {
    print('unable to add game menagers in db');
  }
}

Future<void> updateGameManagersStatusToOngoing(
    String crowdGameId, String status) async {
  var response = await updateGameManagersStatusInDatabase(crowdGameId, status);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1].toString());
  } else {
    print('unable to update game menagers in db');
  }
}

void updateScoreBoard(int currentScore) async {
  String userMail = await getUser();
  var response = await updatePlayerScoreInDatabase(currentScore, userMail);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1].toString());
  } else {
    print('unable to update game menagers in db');
  }
}

Future<void> updateGlobalScoreboard(int currentScore) async {
  String userMail = await getUser();
  var response = await updateGlobalScoreboardInDatabase(currentScore, userMail);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1].toString());
  } else {
    print('unable to update game menagers in db');
  }
}

Future<List<GameScore>> getPlayerScores(String roomid) async {
  var response = await getPlayerScoresFromDatabase(roomid);
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => GameScore.fromJson(e)).toList();
  } else {
    return <GameScore>[];
  }
}

Future<List<GameScore>> getScoreboard() async {
  var response = await getScoreboardFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => GameScore.fromJson(e)).toList();
  } else {
    return <GameScore>[];
  }
}

// REMOVE PLAYER FROM ANY GAMES WHEN QUITTING OR BACKING UP
Future<void> removeMeFromPlayerManager() async {
  final String userMail = await getUser();
  var response = await removeUserFromPlayerManagerInDatabase(userMail);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1].toString());
  } else {
    print('unable to remove user from game rooms');
  }
}

Future<void> removeMyGames() async {
  final String userMail = await getUser();
  var response = await removeGamesCreatedByUserInDatabase(userMail);
  if (response[0] == "OK" && response.length > 1) {
    print(response[1].toString());
  } else {
    print('unable to remove games');
  }
}
