// rest_api_service.dart: We do call the rest API to get, store data on a remote DATABASE
// for that we need to write the rest API call at a single place and need to return the data
// if the rest call is a success or need to return custom error exception on the basis of 4xx, 5xx status code.
// We can make use of http package to make the rest API call in the flutter

import 'dart:convert';
import 'package:event_app/constants/api_path.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/scoreboard_screen.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Future<List> validateRequest(String email, String password) async {
  var url = Uri.parse(eventControlorUrl);
  var response = await http.post(url,
      body: {'action': 'validate', 'mail': email, 'password': password});
  final data = json.decode(response.body);
  return data;
}

Future<List<User>> getAttendees(String eventId) async {
  List<User> attendees =[];
  var url = Uri.parse(messengerControlorUrl);
  var response = await http.post(url, body: {'action': 'listAttendees', 'eventId': eventId});
  final data = json.decode(response.body);
  if (data[0] == 'OK'){
    for (var i = 1; i < data.length -1; i++) {
      User user = User.fromJson(data[i]);
      attendees.add(user);
    }
  }
  return attendees;
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
  var response = await http
      .post(url, body: {'action': 'listEventsForUserMail', 'mail': mail});
  final data = json.decode(response.body);
  return data;
}

//
// MESSENGER REQUESTS
//
Future<List<Conversation>> getConversations(String userMail, String eventId) async {
  List<Conversation> conversations = [];
  var url = Uri.parse(messengerControlorUrl);
  var response = await http.post(url, body: {
    'action': 'listConversations',
    'mail': userMail,
    'eventId': eventId});
  final data = json.decode(response.body);
  if (data[0] == 'OK'){
    for (var i = 1; i < data.length -1; i++) {
      Conversation conversation = Conversation.fromJson(data[i]);
      conversations.add(conversation);
    }
  }
  return conversations;
}

Future<List<Message>> getMessagesForConversation(String convoId) async {
  List<Message> messages = [];
  var url = Uri.parse(messengerControlorUrl);
  var response = await http.post(url, body: {
    'action': 'listMessages',
    'convoid': convoId});
  final data = json.decode(response.body);
  if (data[0] == 'OK'){
    for (var i = 1; i < data.length -1; i++) {
      Message message = Message.fromJson(data[i]);
      messages.add(message);
    }
  }
  return messages;
}

Future<List> sendMessageToConversation(Message message, String convoId) async {
  var url = Uri.parse(messengerControlorUrl);
  var response = await http.post(url, body: {
    'action': 'sendMessage',
    'convoId': convoId,
    'message': message.toJson()
  });
  final data = json.decode(response.body);
  return data;
}
      
Future<List> sendNewMessage(Message message, Conversation conversation, String eventId) async {
  var url = Uri.parse(messengerControlorUrl);
  var body = jsonEncode({
    'action': 'sendNewMessage',
    'eventIt': eventId,
    'conversation': conversation,
    'message': message
  });
  var response = await http.post(url, body: body);
  final data = json.decode(response.body);
  return data;
}
    
//
// CROWD GAMES REQUESTS
//
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

Future<List> getManagersFromDatabase(String roomId) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url,
      body: {'action': 'getManagersForRoomId', 'gameroomid': roomId});
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
    'roomStatus': GameStatus.pending,
  });
  final data = json.decode(response.body);
  return data;
}

Future<List> deleteGameRoomFromDatabase(String roomId) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http
      .post(url, body: {'action': 'deleteGameRoom', 'gameroomid': roomId});
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
  final data = json.decode(response.body);
  return data;
}

Future<List> addGameManagersInDatabase(
    String crowdGameId, List<GameManager> gameManagers) async {
  String insertRequest =
      "INSERT INTO gamemanager (statementnumber, crowdgameid, gamecategory, gameid, starttime, status) VALUES ";
  for (GameManager gm in gameManagers) {
    insertRequest +=
        "(${gm.statementNumber},(SELECT cr.crowdgameid FROM crowdgame cr WHERE LOWER(CONCAT('0x',HEX(cr.crowdgameid)))='$crowdGameId'), ${gm.gameCategory}, ${gm.gameId}, NULL, '${gm.gameStatus}'),";
  }
  insertRequest = insertRequest.substring(0, insertRequest.length - 1);
  insertRequest += ";";

  // String selectRequest =
  //    "SELECT statementnumber, LOWER(CONCAT('0x',HEX(crowdgameid))) as crowdgameid, gamecategory, gameid, starttime, status FROM gamemanager WHERE LOWER(CONCAT('0x',HEX(crowdgameid)))='$crowdGameId';";
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {
    'action': 'createGameManagers',
    'insertRequest': insertRequest,
    //  'selectRequest': selectRequest
  });
  final data = json.decode(response.body);
  return data;
}

Future<List> addPlayerToPlayerManagerInDatabase(
    String userMail, String gameroomid,
    {required score}) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "INSERT INTO playermanager (gameroomid, userid, score) VALUES ((SELECT gr.gameroomid FROM gameroom gr WHERE LOWER(CONCAT('0x',HEX(gr.gameroomid)))='$gameroomid'), (SELECT u.userid FROM users u WHERE u.mail ='$userMail'),$score);";
  var response = await http
      .post(url, body: {'action': 'addPlayerToManager', 'request': request});

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

Future<List> getGameStatusFromDatabase(String crowdGameId, int stmt) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {
    'action': 'getGameStatus',
    'crowdgameid': crowdGameId,
    'statementnumber': stmt.toString()
  });
  final data = json.decode(response.body);
  return data;
}

Future<List> getRoomStatusFromDatabase(String roomid) async {
  var url = Uri.parse(gameControlorUrl);
  var response = await http.post(url, body: {
    'action': 'getRoomStatus',
    'gameroomid': roomid,
  });
  final data = json.decode(response.body);
  return data;
}

Future<List> updateGameStatusInDatabase(
    String crowdGameId, String status) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "UPDATE gamemanager SET status = '$status' WHERE LOWER(CONCAT('0x',HEX(crowdgameid)))='$crowdGameId';";
  var response = await http
      .post(url, body: {'action': 'updateGameStatus', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> updateGameProgressInDatabase(String roomid, int progress) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "UPDATE gameroom SET progress = $progress WHERE LOWER(CONCAT('0x',HEX(gameroomid)))='$roomid';";
  var response = await http.post(url,
      body: {'action': 'updateSingleGameStatus', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> updateGameManagersStatusInDatabase(
    String crowdGameId, String status) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "UPDATE gamemanager SET status = '$status' WHERE LOWER(CONCAT('0x',HEX(crowdgameid)))='$crowdGameId';";
  var response = await http.post(url,
      body: {'action': 'updateGameManagersStatus', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> updateSingleGameStatusInDatabase(
    String roomid, int stmt, String status) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "UPDATE gamemanager gm JOIN crowdgame cg ON LOWER(CONCAT('0x',HEX(gm.crowdgameid))) = LOWER(CONCAT('0x',HEX(cg.crowdgameid))) SET gm.status = '$status' WHERE LOWER(CONCAT('0x',HEX(cg.gameroomid)))='$roomid' AND gm.statementnumber = $stmt;";
  var response = await http.post(url,
      body: {'action': 'updateSingleGameStatus', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> updateRoomStatusInDatabase(String roomid, String status) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "UPDATE gameroom SET roomStatus = '$status' WHERE LOWER(CONCAT('0x',HEX(gameroomid)))='$roomid';";
  var response = await http
      .post(url, body: {'action': 'updateRoomStatus', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> updatePlayerScoreInDatabase(
    int currentScore, String userMail) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "UPDATE playermanager SET score = $currentScore WHERE LOWER(CONCAT('0x',HEX(userid))) = (SELECT LOWER(CONCAT('0x',HEX(u.userid))) FROM users u WHERE u.mail='$userMail');";
  var response = await http
      .post(url, body: {'action': 'updatePlayerScore', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> getPlayerScoresFromDatabase(String roomid) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "SELECT u.prenom, u.mail, pm.score FROM users u JOIN playermanager pm USING (userid) WHERE LOWER(CONCAT('0x',HEX(pm.gameroomid))) = '$roomid' ORDER BY pm.score DESC;";
  var response = await http
      .post(url, body: {'action': 'getPlayerScores', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> getScoreboardFromDatabase() async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "SELECT u.prenom, u.mail, s.score FROM users u JOIN scoreboard s USING (userid) ORDER BY s.score DESC;";
  var response = await http
      .post(url, body: {'action': 'getPlayerScores', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> updateGlobalScoreboardInDatabase(
    int currentScore, String userMail) async {
  var url = Uri.parse(gameControlorUrl);
  String request =
      "INSERT INTO scoreboard SET userid = (SELECT u.userid FROM users u WHERE u.mail='$userMail'), score = $currentScore ON DUPLICATE KEY UPDATE score = (score + $currentScore);";
  var response = await http.post(url,
      body: {'action': 'updateGlobalScoreboard', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> removeUserFromPlayerManagerInDatabase(String userMail) async {
  var url = Uri.parse(gameControlorUrl);

  String request =
      "DELETE FROM playermanager WHERE LOWER(CONCAT('0x',HEX(userid))) = (SELECT LOWER(CONCAT('0x',HEX(u.userid))) FROM users u WHERE u.mail='$userMail');";
  var response = await http.post(url,
      body: {'action': 'deletePlayerFromPlayerManager', 'request': request});
  final data = json.decode(response.body);
  return data;
}

Future<List> removeGamesCreatedByUserInDatabase(String userMail) async {
  var url = Uri.parse(gameControlorUrl);

  String request =
      "DELETE FROM gameroom WHERE LOWER(CONCAT('0x',HEX(userid))) = (SELECT LOWER(CONCAT('0x',HEX(u.userid))) FROM users u WHERE u.mail='$userMail');";
  var response = await http.post(url,
      body: {'action': 'deletePlayerFromPlayerManager', 'request': request});
  final data = json.decode(response.body);
  return data;
}

// CAR POOL REQUESTS
Future<List> getCarPoolUserFromDatabase() async {
  var user = await getUser();
  return getCarPoolUserByEmailFromDatabase(user);
}

Future<List> getCarPoolUserByEmailFromDatabase(String email) async {
  var url = Uri.parse(carpoolControlorUrl);
  var response = await http.post(url, body: {'action': 'getUserByMail', 'email': email});
  final data = json.decode(response.body);

  return data;
}

Future<List> getCarPoolForEventFromDatabase(String eventid) async {
  var url = Uri.parse(carpoolControlorUrl);
  var response = await http.post(url, body: {'action': 'getAvailableCarPoolByEventId', 'eventid': eventid});
  final data = json.decode(response.body);
  return data;
}