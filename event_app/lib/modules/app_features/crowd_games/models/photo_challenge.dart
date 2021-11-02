import 'package:event_app/modules/app_features/crowd_games/models/game.dart';

class PhotoChallenge extends Game {
  int id;
  String categ;
  String stmt;
  int photoCount;

  PhotoChallenge(this.id, this.categ, this.stmt, this.photoCount)
      : super(gameid:id, category:categ, statement:stmt);

  factory PhotoChallenge.fromJson(Map<String, dynamic> json) {
      return PhotoChallenge(
        int.parse(json['gameid']),
        json['category'],
        json['description'],
        int.parse(json['photocount']));
  }
}
