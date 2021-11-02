// rest_api_service.dart: We do call the rest API to get, store data on a remote DATABASE
// for that we need to write the rest API call at a single place and need to return the data
// if the rest call is a success or need to return custom error exception on the basis of 4xx, 5xx status code.
// We can make use of http package to make the rest API call in the flutter

import 'dart:convert';
import 'package:event_app/constants/api_path.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Future<List> validateRequest(String email, String password) async {
  var url = Uri.parse(eventControlorUrl);
  var response = await http.post(url,
      body: {'action': 'validate', 'mail': email, 'password': password});
  final data = json.decode(response.body);
  return data;
}

Future<List> getUserDetailsFromDatabase(String userMail) async {
  var url = Uri.parse(eventControlorUrl);
  var response = await http
      .post(url, body: {'action': 'getUserDetails', 'mail': userMail});
  final data = json.decode(response.body);
  return data;
}

//EventList
Future<List> getEventsListFromDatabase(String mail) async {
  var url = Uri.parse(eventControlorUrl);
  var response = await http.post(url, body: {'action': 'listEventsForUserMail', 'mail': mail});
  final data = json.decode(response.body);
  return data;
}

// CROWD GAMES REQUESTS
Future<List> getGameRoomListFromDatabase() async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {'action': 'listGameRooms'});
  final data = json.decode(response.body);
  return data;
}

Future<List> getPlayersInGameRoomFromDatabase(String roomId) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http
      .post(url, body: {'action': 'getPlayersForRoomId', 'gameroomid': roomId});
  final data = json.decode(response.body);
  return data;
}

Future<List> createGameRoomInDatabase(String creatorid) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {
    'action': 'createGameRoom',
    'createdAt':
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
    'creatorid': creatorid,
    'capacity': GameRoom.playerCapacity.toString(),
    'playerCount': '1',
    'progress': '0',
    'roomStatus': GameStatus.pending
  });
  print(response.body);
  final data = json.decode(response.body);
  return data;
}

Future<List> deleteGameRoomFromDatabase(String roomId) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http
      .post(url, body: {'action': 'deleteGameRoom', 'gameroomid': roomId});
  print(response.body);
  final data = json.decode(response.body);
  return data;
}

Future<List> getGameCountsFromDatabase() async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {'action': 'getNumberOfGames'});
  final data = json.decode(response.body);
  return data;
}

Future<List> addCrowdGameInDatabase(CrowdGame crowdGame) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {
    'action': 'createCrowdGame',
    'gameroomid': crowdGame.gameroomid,
    'createdAt': DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(crowdGame.createdAt)
        .toString(),
    'statementcount': CrowdGame.statementCount.toString(),
    'currentgamepos': crowdGame.currentGamePos.toString(),
    'status': crowdGame.crowdGameStatus
  });
  print("Crowd game added: " + response.body);
  final data = json.decode(response.body);
  return data;
}

Future<List> addGameManagersInDatabase(
    String crowdGameId, List<GameManager> gameManagers) async {
  String insertRequest = "";
  //for (GameManager gm in gameManagers) {
  //  print(gm.startTime);
    insertRequest =
        //"INSERT INTO gamemanager (crowdgameid, gamecategory, gameid, starttime, status) VALUES ((SELECT cr.crowdgameid FROM crowdgame cr WHERE LOWER(CONCAT('0x',HEX(cr.crowdgameid)))='$crowdGameId'), ${gm.gameCategory}, ${gm.gameId}, '${gm.startTime != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(gm.startTime!) : "NULL"}', '${gm.gameStatus}');";
        "INSERT INTO gamemanager (crowdgameid, gamecategory, gameid, starttime, status) VALUES ((SELECT cr.crowdgameid FROM crowdgame cr WHERE LOWER(CONCAT('0x',HEX(cr.crowdgameid)))='0x945d03013bfe11ecbe130cc47ad3b416'), 2, 1, NULL, 'ongoing');";
  //}

  String selectRequest =
      // "SELECT LOWER(CONCAT('0x',HEX(crowdgameid))) as crowdgameid, gamecategory, gameid, starttime, status FROM gamemanager WHERE LOWER(CONCAT('0x',HEX(crowdgameid)))=$crowdGameId;";
      "SELECT LOWER(CONCAT('0x',HEX(crowdgameid))) as crowdgameid, gamecategory, gameid, starttime, status FROM gamemanager WHERE LOWER(CONCAT('0x',HEX(crowdgameid)))='0x945d03013bfe11ecbe130cc47ad3b416';";
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {
    'action': 'createGameManagers',
    'insertRequest': insertRequest,
    'selectRequest': selectRequest
  });
  print("Game managers added : " + response.body);
  final data = json.decode(response.body);
  return data;
}

Future<List> getQuizzesFromDatabase() async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {'action': 'getQuizzes'});
  final data = json.decode(response.body);
  return data;
}

Future<List> getPhotoChallengesFromDatabase() async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {'action': 'getPhotoChallenges'});
  final data = json.decode(response.body);
  return data;
}

Future<List> getActionChallengesFromDatabase() async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {'action': 'getActionChallenges'});
  final data = json.decode(response.body);
  return data;
}

