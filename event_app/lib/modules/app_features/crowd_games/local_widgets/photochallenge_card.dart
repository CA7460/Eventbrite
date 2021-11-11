import 'dart:async';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/game_timer.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/picture_frame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/photo_challenge.dart';

class PhotoHuntCard extends StatefulWidget {
  final PhotoChallenge photoChallenge;
  final int statementNumber;
  final int timerState;
  // final bool _canPlay;
  final void Function(int) callbackPoints;
    final void Function() scrollToCurrentStatement;
  final void Function() callbackAdvance;

  const PhotoHuntCard(this.photoChallenge, this.callbackPoints, this.scrollToCurrentStatement,  this.callbackAdvance,
      {required this.timerState, required this.statementNumber, Key? key})
      : super(key: key);

  @override
  _PhotoHuntCardState createState() => _PhotoHuntCardState();
}

class _PhotoHuntCardState extends State<PhotoHuntCard>
    with AutomaticKeepAliveClientMixin {
  // late CameraController controller;
  // late String imagePath;
  // Timer? _timer;
  // int _now = Game.timeAllowed;

  @override
  bool get wantKeepAlive => true;

  // @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  // }

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_now == 0) {
  //         setState(() {
  //           timer.cancel();
  //         });
  //       } else {
  //         setState(() {
  //           _now--;
  //         });
  //       }
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   _timer!.cancel();
  //   super.dispose();
  // }

  void advanceToNextGame() {
    widget.callbackAdvance();
  }

  @override
  Widget build(BuildContext context) {
    // DIVISER L'ÉCRAN EN 3 GAME DE HAUTEUR? OU 4 ?

    return Container(
      height: 230,
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
                          widget.photoChallenge.categ,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    GameTimer(widget.timerState, widget.scrollToCurrentStatement,  advanceToNextGame),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28, 5, 0, 10),
                child: Text(widget.photoChallenge.statement,
                    style: TextStyle(color: Colors.white70, fontSize: 15)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: getPictureFrame(widget.photoChallenge.photoCount),
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

List<Widget> getPictureFrame(int count) {
  int i = 0;
  List<Widget> list = <Widget>[];
  while (i < count) {
    list.add(PictureFrame());
    i++;
  }
  return list;
}
