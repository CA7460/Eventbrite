class Player {
  String roomId;
  String userId;
  String name;
  int score;

  Player(this.roomId, this.userId, this.name, this.score);

  Player.fromJson(Map<String, dynamic> json)
      : roomId = json['gameroomid'],
        userId = json['userid'],
        name = json['prenom'],
        score = json['score'];
}
