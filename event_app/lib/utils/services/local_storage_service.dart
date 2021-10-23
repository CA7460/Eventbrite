// local_storage_service.dart: In this file, we write all the code needed to store and get data from the local storage
// using the plugin shared_preferences.
// In this file, there will be getters and setters for each and every data to be stored in the local storage.


import 'package:shared_preferences/shared_preferences.dart';

getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('user');
  return user; 
}

setUser(String user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', user);
}