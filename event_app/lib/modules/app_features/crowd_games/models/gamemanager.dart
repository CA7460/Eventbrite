import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';

class GameManager {
  String crowdGameId = "";
  int gameCategory;
  int gameId;

  DateTime? _startTime = DateTime
      .now(); // ou en String -> DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
  String? gameStatus;

  GameManager({required this.gameCategory, required this.gameId});

  DateTime? get startTime => _startTime;
  set startTime(DateTime? time) {
    _startTime = time;
  }

  GameManager.fromJson(Map<String, dynamic> json)
      : crowdGameId = json['crowdgameid'],
        gameCategory = int.parse(json['gamecategory']),
        gameId = int.parse(json['gameid']),
        _startTime = DateTime.parse(json['starttime']),
        gameStatus = json['status'];
}
