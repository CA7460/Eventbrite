import 'package:event_app/modules/app_features/crowd_games/models/game.dart';

class Quiz extends Game {

  int id;
  String categ;
  String question;
  String answerChoices;
  int rightAnswerPos;

  Quiz(this.id, this.categ, this.question, this.answerChoices, this.rightAnswerPos)
      : super(gameid:id, category:categ, statement:question);

  factory Quiz.fromJson(Map<String, dynamic> json) {
      return Quiz(
        int.parse(json['gameid']),
        json['category'],
        json['question'],
        json['answerchoices'],
        int.parse(json['rightanswerpos']));
  }
}
