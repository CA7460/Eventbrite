import 'dart:async';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:flutter/material.dart';

class GameTimer extends StatefulWidget {
  // final bool _canPlay;
  final int timerState;
  final void Function() scrollToCurrentStatement;
  final void Function() callbackAdvance;
  const GameTimer(
      this.timerState, this.scrollToCurrentStatement, this.callbackAdvance,
      {Key? key})
      : super(key: key);
  @override
  _GameTimerState createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer> {
  Timer? _timer;
  int _now = Game.timeAllowed;
  @override
  void initState() {
    super.initState();

    if (widget.timerState > 0) {
      _now = 0;
    } else {
      startTimer();
    }
  }

  Future<void> delayTimerStart({required int seconds}) async {
    print('delaying first timer');
    Timer(Duration(seconds: seconds), () {
      widget.scrollToCurrentStatement();
      startTimer();
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_now == 0) {
          widget.callbackAdvance();
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _now--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text("00:" + (_now >= 10 ? "$_now" : "0$_now "),
              style: TextStyle(color: Colors.white)),
          Icon(
            Icons.timer,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
