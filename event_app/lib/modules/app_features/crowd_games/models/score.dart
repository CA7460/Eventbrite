class GameScore {
  String player;
  String mail;
  int score;

  GameScore(this.player, this.mail, this.score);

  GameScore.fromJson(Map<String, dynamic> json)
      : player = json['player'],
        mail = json['mail'],
        score = int.parse(json['score']);
}
