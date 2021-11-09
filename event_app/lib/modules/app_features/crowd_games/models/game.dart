import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';

class Game {
  static const int timeAllowed = 5;
  static const int pointsEarned = 50;

  int gameid;
  String category;
  String statement;
  // DateTime _startTime = DateTime.now(); // ou en String -> DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
  // String gameStatus = GameStatus.pending;

  Game({required this.gameid, required this.category, required this.statement});

  // set startTime(DateTime time) {
  //   _startTime = time;
  // }
}
