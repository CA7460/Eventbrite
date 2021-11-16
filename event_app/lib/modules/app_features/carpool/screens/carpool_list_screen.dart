import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/carpool.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/modules/app_features/carpool/screens/carpool_driver_screen.dart';
import 'package:event_app/modules/app_features/carpool/screens/carpool_passenger_screen.dart';

// Future navigerEcrans(context, ecran) async {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => ecran));
// }

class CarPoolListScreen extends StatefulWidget {
  final EventMod event;
  const CarPoolListScreen({Key? key, required this.event}) : super(key: key);

  @override
  _CarPoolListScreenState createState() => _CarPoolListScreenState();
}

class _CarPoolListScreenState extends State<CarPoolListScreen> {
  late Future<List<CarPool>> _carPoolFuture;

  //final EventMod event;
  //_CarPoolListScreenState(this.event);

  @override
  void initState() {
    super.initState();
    _carPoolFuture = getCarPool();

    //print('Event itemid: ' + event.eventid);
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
    
    // pour avoir le event , faire widget.event

    print(widget.event.eventid);
    print(widget.event.city);

    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.55;
    final bottomLayoutHeight = screenSize.height * 0.8;
    return Center(
      child: Column(
        children: [
          Container(
            height: bottomLayoutHeight,
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryButton2("I'am a driver", Colors.black,
                    onPressed: () => {
                          // navigerEcrans(context, CarpoolDriverScreen())
                          Utils.carpoolNav.currentState!
                              .pushNamed(carPoolDriverRoute)
                        }),
                PrimaryButton3("I'am a passenger", Colors.black,
                    onPressed: () => {
                          // navigerEcrans(context, CarpoolPassengerScreen())
                          Utils.carpoolNav.currentState!
                              .pushNamed(carPoolPassengerRoute)
                        }),
              ],
            ),
          ),
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
          : ListView.builder(
              itemCount: carpool.length,
              //itemBuilder: listBuilder,
              itemBuilder: (context, index) {
                return CarPoolListItem(refreshCarPoolList, carpool, index);
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

class PrimaryButton2 extends StatelessWidget {
  final String btnText;
  final Color btnColor = Colors.black;
  final GestureTapCallback onPressed;

  const PrimaryButton2(this.btnText, btnColor, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidthForCard = screenWidth / 2;
    final cardSize = maxWidthForCard - 20;
    final labelWidth = cardSize - 26;
    return ElevatedButton(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: cardSize,
                height: cardSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: AssetImage("assets/images/driver.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 14,
                left: (cardSize - labelWidth) / 2,
                child: Container(
// black box that wraps the white text
                  width: labelWidth,
                  color: Color(0xc53a4155),
                  padding: EdgeInsets.all(10),
                  child: Text("I\'am a driver",
                      style: TextStyle(fontSize: 16, color: Color(0xffc8f1f1)),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

class PrimaryButton3 extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final GestureTapCallback onPressed;

  const PrimaryButton3(this.btnText, this.btnColor, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidthForCard = screenWidth / 2;
    final cardSize = maxWidthForCard - 20;
    final labelWidth = cardSize - 26;
    return ElevatedButton(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: cardSize,
                height: cardSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: AssetImage("assets/images/passenger.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 14,
                left: (cardSize - labelWidth) / 2,
                child: Container(
// black box that wraps the white text
                  width: labelWidth,
                  color: Color(0xc53a4155),
                  padding: EdgeInsets.all(10),
                  child: Text("I\'am a passenger",
                      style: TextStyle(fontSize: 16, color: Color(0xffc8f1f1)),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
