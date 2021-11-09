import 'dart:async';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/game_timer.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/ingame_button.dart';
import 'package:event_app/modules/app_features/crowd_games/models/action_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatefulWidget {
  final ActionChallenge actionChallenge;
  final int statementNumber;
  final int timerState;
  // final bool _canPlay;
  final void Function(int) callbackPoints;
    final void Function() scrollToCurrentStatement;
  final void Function() callbackAdvance;


  const ActionCard(
      this.actionChallenge, this.callbackPoints, this.scrollToCurrentStatement,  this.callbackAdvance,
      {required this.timerState, required this.statementNumber, Key? key})
      : super(key: key);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard>
    with AutomaticKeepAliveClientMixin {
  // Timer? _timer;
  // int _now = Game.timeAllowed;
  Color btnColor = primary_blue;
  bool isClickable = true;

  @override
  bool get wantKeepAlive => true;

  void challengeDone() {
    if (isClickable) {
      widget.callbackPoints(Game.pointsEarned);
      btnColor = Colors.lightGreen[800]!;
      isClickable = false;
      //setState(() {});
    }
  }

  void advanceToNextGame() {
    isClickable = false;
    widget.callbackAdvance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
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
                          widget.actionChallenge.categ,
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
                padding: EdgeInsets.fromLTRB(28, 5, 0, 40),
                child: Text(widget.actionChallenge.statement,
                    style: TextStyle(color: Colors.white70, fontSize: 15)),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: InGameButton(
                      btnText: "DONE",
                      color: btnColor,
                      onPressed: () => challengeDone()),
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
