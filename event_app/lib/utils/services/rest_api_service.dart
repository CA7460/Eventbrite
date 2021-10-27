// rest_api_service.dart: We do call the rest API to get, store data on a remote DATABASE
// for that we need to write the rest API call at a single place and need to return the data
// if the rest call is a success or need to return custom error exception on the basis of 4xx, 5xx status code.
// We can make use of http package to make the rest API call in the flutter

import 'dart:convert';
import 'package:event_app/constants/api_path.dart';
import 'package:http/http.dart' as http;

Future<List> validateRequest(String email, String password) async {
  var url = Uri.parse(eventControlorUrl);
  var response = await http.post(url,
      body: {'action': 'validate', 'mail': email, 'password': password});
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
