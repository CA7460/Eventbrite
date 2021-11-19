import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/car_pool_event.dart';
import 'package:event_app/modules/app_features/carpool/models/user_person.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/scoreboard_screen.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/modules/app_features/carpool/screens/carpool_passenger_screen.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/event_manager/local_widgets/event_list_item.dart';
import 'package:event_app/modules/event_manager/screens/event_manager_screen.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carpool_list_screen.dart';

Future navigerEcrans(context, ecran) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ecran));
}

class CarpoolPassengerScreen extends StatefulWidget {
  final EventMod event;
  const CarpoolPassengerScreen({Key? key, required this.event}) : super(key: key);

  @override
  _CarpoolPassengerScreenState createState() => _CarpoolPassengerScreenState(event);
}

class _CarpoolPassengerScreenState extends State<CarpoolPassengerScreen> {
  final EventMod event;
  late Future<List<CarPoolEvent>> _carpoolEvents;

  _CarpoolPassengerScreenState(this.event);

  @override
  void initState() {
    super.initState();
    _carpoolEvents = getCarPoolEvents();
  }

  void refreshCarPoolList() {
    setState(() {
      _carpoolEvents = getCarPoolEvents();
    });
  }

  Future<List<CarPoolEvent>> getCarPoolEvents() async {
    var response = await getCarPoolForEventFromDatabase('0x0d70522f2dbb11ec97710cc47ad3b416');
    if (response[0] == "OK" && response.length > 1) {
      response.removeAt(0);
      print(response[0].toString());
      return response.map((event) => CarPoolEvent.fromJson(event)).toList();
    }
    return <CarPoolEvent>[];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.95;
    return Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: centerLayoutHeight,
              color: primary_background,
              child: FutureBuilder<List<CarPoolEvent>>(
                  future: getCarPoolEvents(),
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<List<CarPoolEvent>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      List<CarPoolEvent> events = snapshot.data!;
                      return CarPoolEventsListViewWidget(events, this);
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ));
  }
}

class CarPoolEventsListViewWidget extends StatelessWidget {
  final List<CarPoolEvent> events;
  final dynamic _listViewStateInstance;

  const CarPoolEventsListViewWidget(this.events, this._listViewStateInstance,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: events.isEmpty
          ? emptyList()
          : ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return CarPoolEventListItem(events, index);
          }),
    );
  }

  Widget emptyList() {
    return Text(
      'No Events availble',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}

class CarPoolEventListItem extends StatelessWidget {
  final List<CarPoolEvent> carPoolEvents;
  final int index;
  const CarPoolEventListItem(this.carPoolEvents, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CarPoolEvent carPoolEvent = Provider.of<CarPoolEvent>(context);
    return Card(
        margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
        color: Colors.deepOrange,
        borderOnForeground: true,
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              //Provider a maintenant l'evenement en cours
              //carPoolEvent.makeCurrentEvent(carPoolEvents[index]);
              Utils.mainAppNav.currentState!.pushNamed(carPoolPassengerRoute, arguments: carPoolEvents[index]);
              // Utils.mainAppNav.currentState!
              //     .pushNamed(carPoolListRoute, arguments: events[index]);
            },
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(carPoolEvents[index].title, //nom event
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(carPoolEvents[index].description,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    Text(
                        carPoolEvents[index].createdOn.toString() +
                            "/" + carPoolEvents[index].createdOn.toString() +
                            "/" + carPoolEvents[index].createdOn.toString(),
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ]),
            )));
  }
}