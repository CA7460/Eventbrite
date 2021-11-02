import 'package:event_app/modules/app_features/crowd_games/models/game.dart';

class ActionChallenge extends Game {
  int id;
  String categ;
  String stmt;

  ActionChallenge(this.id, this.categ, this.stmt)
      : super(gameid: id, category: categ, statement: stmt);

  factory ActionChallenge.fromJson(Map<String, dynamic> json) {
      return ActionChallenge(
        int.parse(json['gameid']),
        json['category'],
        json['description']);
  }
}
