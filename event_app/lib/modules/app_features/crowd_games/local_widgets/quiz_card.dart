import 'dart:async';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/game_timer.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/ingame_button.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/quiz.dart';
// import 'package:event_app/utils/utils.dart';
// import 'package:event_app/config/routes/routes.dart';
// import 'package:event_app/utils/services/rest_api_service.dart';

class QuizCard extends StatefulWidget {
  final Quiz _quiz;
  final int statementNumber;
  final int timerState;
  // final bool _canPlay;
  final void Function(int) callbackPoints;
  final void Function() scrollToCurrentStatement;
  final void Function() callbackAdvance;

  const QuizCard(this._quiz, this.callbackPoints, this.scrollToCurrentStatement, this.callbackAdvance,  
      {required this.timerState, required this.statementNumber, Key? key})
      : super(key: key);

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard>
    with AutomaticKeepAliveClientMixin {
  List<Color> btnColor = [
    primary_blue,
    primary_blue,
    primary_blue,
    primary_blue
  ];
  bool isClickable = true;

  @override
  bool get wantKeepAlive => true;

  void answerChoiceIndex(int answerPos) {
    int rightAnswerPos = widget._quiz.rightAnswerPos;
    int points = 0;
    if (isClickable) {
      if (answerPos == rightAnswerPos) {
        btnColor[answerPos] = Colors.lightGreen[800]!;
        points = Game.pointsEarned;
      } else {
        btnColor[answerPos] = primary_red;
        btnColor[rightAnswerPos] = Colors.lightGreen[800]!;
      }
      isClickable = false;
      widget.callbackPoints(points);
      // setState(() {});
    }
  }

  void advanceToNextGame() {
    isClickable = false;
    widget.callbackAdvance();
  }

  @override
  Widget build(BuildContext context) {
    var answers = widget._quiz.answerChoices.split(",");

    List<InGameButton> btnList = [
      InGameButton(
          btnText: answers[0],
          color: btnColor[0],
          onPressed: () => answerChoiceIndex(0)),
      InGameButton(
          btnText: answers[1],
          color: btnColor[1],
          onPressed: () => answerChoiceIndex(1)),
      InGameButton(
          btnText: answers[2],
          color: btnColor[2],
          onPressed: () => answerChoiceIndex(2)),
      InGameButton(
          btnText: answers[3],
          color: btnColor[3],
          onPressed: () => answerChoiceIndex(3))
    ];

    return Container(
      height: 250,
      child: Card(
        margin: EdgeInsets.fromLTRB(28, 20, 22, 0),
        color: primary_background,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.statementNumber.toString() +
                          ". " +
                          widget._quiz.categ,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    GameTimer(widget.timerState, widget.scrollToCurrentStatement, advanceToNextGame),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28, 5, 0, 5),
                child: Text(widget._quiz.question,
                    style: TextStyle(color: Colors.white70, fontSize: 15)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: btnList[0],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: btnList[1],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: btnList[2],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: btnList[3],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
