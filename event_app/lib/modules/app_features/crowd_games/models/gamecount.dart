class GameCount {
  int quizCount;
  int photoChallengeCount;
  int actionChallengeCount;

  GameCount(
      this.quizCount, this.photoChallengeCount, this.actionChallengeCount);

  GameCount.fromJson(Map<String, dynamic> json)
      : quizCount = int.parse(json['quizcount']),
        photoChallengeCount = int.parse(json['photochallengecount']),
        actionChallengeCount = int.parse(json['actionchallengecount']);
}
