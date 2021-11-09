import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/carpool.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';

class CarPoolListScreen extends StatefulWidget {
  const CarPoolListScreen({Key? key}) : super(key: key);
  @override
  _CarPoolListScreenState createState() => _CarPoolListScreenState();
}

class _CarPoolListScreenState extends State<CarPoolListScreen> {
  late Future<List<CarPool>> _carPoolFuture;

  @override
  void initState() {
    super.initState();
    _carPoolFuture = getCarPool();
  }

  void refreshCarPoolList() {
    print('refreshing list');
    setState(() {
      _carPoolFuture = getCarPool();
    });
  }

  Future<List<CarPool>> getCarPool() async {
  var response = await getCarPoolListFromDatabase();
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((carpool) => CarPool.fromJson(carpool)).toList();
  }
  return <CarPool>[];
}

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.55;
    final bottomLayoutHeight = screenSize.height * 0.35;
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: topLayoutHeight,
            child: GestureDetector(
                onTap: () {
                  print("refresh btn pressed");
                  refreshCarPoolList();
                },
                child: Text("Refresh list",
                    style: TextStyle(color: primary_blue))),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: centerLayoutHeight,
            color: primary_background,
            child: FutureBuilder<List<CarPool>>(
                future: _carPoolFuture,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<CarPool>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!;
                    return CarPoolListViewWidget(
                        refreshCarPoolList, items, this);
                    // List<GameRoom> gamerooms = snapshot.data!;
                    // return GameRoomListViewWidget(gamerooms, this);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            // ),
          ),
          /*Container(
            height: bottomLayoutHeight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryButton('Create game', primary_blue,
                    onPressed: () =>
                        // {Navigator.pushNamed(context, enterGameRoomRoute)}),
                        {
                          Utils.appFeaturesNav
                              .currentState! // pushReplacementNamed remplace la route, on ne peut pas back dessus
                              .pushNamed(createGameRoute)
                              .then((value) {
                            refreshGameRoomList();
                          }) // pushNamed permet de pop()
                          //  AJOUTER UNE NOUVELLE ROUTE POUR CREATE GAME
                        }),
                PrimaryButton('Scoreboard', primary_blue,
                    onPressed: () => {
                          Utils.appFeaturesNav.currentState!
                              .pushNamed(scoreboardRoute)
                        }),
                PrimaryButton('Car Pool', primary_blue,
                    onPressed: () =>
                    // {Navigator.pushNamed(context, enterCarPoolRoute)}),
                    {
                      Utils.appFeaturesNav
                          .currentState! // pushReplacementNamed remplace la route, on ne peut pas back dessus
                          .pushNamed(carPoolRoute)
                          .then((value) {
                        refreshGameRoomList();
                      }) // pushNamed permet de pop()
                    }),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}

class CarPoolListViewWidget extends StatelessWidget {
  final Function refreshCarPoolList;
  final List<CarPool> carpool;
  final dynamic _listViewStateInstance;

  const CarPoolListViewWidget(
      this.refreshCarPoolList, this.carpool, this._listViewStateInstance,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: carpool.isEmpty
          ? emptyList()
          : //RefreshIndicator(   // Pour les scrollable, permet de tjrs avoir une liste à jour
              //child: 
              ListView.builder(
                  itemCount: carpool.length,
                  //itemBuilder: listBuilder,
                  itemBuilder: (context, index) {
                    return CarPoolListItem(
                        refreshCarPoolList, carpool, index);
                  }),
              //onRefresh:
              //refreshGameRoomList(), // called when the user pulls the list down enough to trigger this event
            //),
    );
  }

  Widget emptyList() {
    return Text(
      'No available routes',
      style: TextStyle(color: Colors.white),
    );
  }
}