import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/models/score.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';

Future<String> getUserMail() async {
  String userMail = await getUser();
  return userMail;
}

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({Key? key}) : super(key: key);

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  late Future<List<GameScore>> _scoreBoardFuture;
  String _userMail = "";

  @override
  void initState() {
    super.initState();
    getUserMail().then((result) => _userMail = result);
    _scoreBoardFuture = getScoreboard();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<GameScore>>(
          future: _scoreBoardFuture,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<GameScore>> snapshot,
          ) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              if (items.isNotEmpty) {
                String rankString = "", namesString = "", pointsString = "";
                int userRank = 0;
                int userScore = 0;
                int rank = 1;

                for (GameScore score in items) {
                  rankString += rank.toString() + "\n";
                  namesString += "${score.player}\n";
                  pointsString += "${score.score}\n";
                  if (score.mail == _userMail) {
                    userRank = rank;
                    userScore = score.score;
                  }
                  rank++;
                }

                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: eventbrite_red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: 220,
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text("Personal score",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          Text("$userScore pts",
                              style: TextStyle(
                                  color: primary_green, fontSize: 24)),
                          SizedBox(height: 20),
                          Text("Rank",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          Text(userRank.toString(),
                              style: TextStyle(
                                  color: primary_green, fontSize: 24)),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    Text("High Score",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text("Name",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Text(namesString,
                                  style: TextStyle(color: primary_pink)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text("Points",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Text(pointsString,
                                  style: TextStyle(color: primary_pink)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text("Rank",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Text(rankString,
                                  style: TextStyle(color: primary_pink)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text(
                      "Scoreboard is empty!\nCreate game to gain points",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primary_blue,
                ),
              );
            }
          }),
    );
  }
}
