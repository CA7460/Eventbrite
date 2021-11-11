import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';

class GameManager {
  int statementNumber;
  String crowdGameId = "";
  int gameCategory;
  int gameId;

  DateTime? _startTime = DateTime
      .now(); // ou en String -> DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
  String gameStatus = GameStatus.pending;

  GameManager({required this.statementNumber, required this.gameCategory, required this.gameId});

  DateTime? get startTime => _startTime;
  set startTime(DateTime? time) {
    _startTime = time;
  }

  // VERSION GAME SCREEN (CREATE GAME)
  // GameManager.fromJson(Map<String, dynamic> json)
  //     : statementNumber = int.parse(json['statementnumber']),
  //       crowdGameId = json['crowdgameid'],
  //       gameCategory = int.parse(json['gamecategory']),
  //       gameId = int.parse(json['gameid']),
  //       _startTime = json['starttime'] != null
  //           ? DateTime.parse(json['starttime'])
  //           : null,
  //       gameStatus = json['status'];

    GameManager.fromJson(Map<String, dynamic> json)
      : statementNumber = json['statementnumber'],
        crowdGameId = json['crowdgameid'],
        gameCategory = json['gamecategory'],
        gameId = json['gameid'],
        _startTime = json['starttime'] != null
            ? DateTime.parse(json['starttime'])
            : null,
        gameStatus = json['status'];
}
