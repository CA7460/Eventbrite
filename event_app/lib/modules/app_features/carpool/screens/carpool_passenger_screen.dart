//class CarpoolPassengerScreen extends StatelessWidget {

import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/carpool.dart';
import 'package:flutter/material.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/modules/app_features/carpool/screens/carpool_driver_screen.dart';

Future navigerEcrans(context, ecran) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ecran));
}

class CarpoolPassengerScreen extends StatefulWidget {
  const CarpoolPassengerScreen({Key? key}) : super(key: key);
  @override
  _CarpoolPassengerScreenState createState() => _CarpoolPassengerScreenState();
}

class _CarpoolPassengerScreenState extends State<CarpoolPassengerScreen> {
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
    final bottomLayoutHeight = screenSize.height * 0.5;
    return Center(
      child: Column(
        children: [
          Container(
            height: bottomLayoutHeight,
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryButton3('I am a passenger', Colors.black ,
                    onPressed: () => {
                      //navigerEcrans(context, CarpoolPassengerScreen())
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
                  child: Text("I'am a passenger",
                      style: TextStyle(
                          fontSize: 16, color: Color(0xffc8f1f1)),
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





