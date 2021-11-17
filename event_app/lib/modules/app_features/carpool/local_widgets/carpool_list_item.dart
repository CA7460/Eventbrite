import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/carpool/models/car_pool.dart';
import 'package:event_app/modules/app_features/crowd_games/local_widgets/join_game_button.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:flutter/material.dart';

class CarPoolListItem extends StatelessWidget {
  final Function refreshCarPoolList;
  final List<CarPool> carpools;
  final int index;
  const CarPoolListItem(this.refreshCarPoolList, this.carpools, this.index,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
      color: primary_background,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
              child: Text("Title: " + carpools[index].title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 3),
                        child: Text(
                            "Number of Seats:  ${carpools[index].numberOfSeats}}",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 3),
                        child: Text("Status ${carpools[index].status}%",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      /*JoinGameButton(
                          onPressed: () => Utils.appFeaturesNav.currentState!
                                  .pushNamed(carPoolListRoute,
                                      arguments: carpools[index])
                                  .then((value) {
                                refreshCarPoolList();
                              })),*/
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
