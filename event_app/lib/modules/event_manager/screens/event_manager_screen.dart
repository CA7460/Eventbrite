import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/event_manager/local_widgets/event_list_item.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';

Future<List<EventMod>> getEvents() async {
  //fetch le mail du user dans local_storage
  String mail = await getUser();
  //demande des events lier au user dans database
  var response = await getEventsListFromDatabase(mail);
  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((event) => EventMod.fromJson(event)).toList();
  }
  return <EventMod>[];
}

class EventManagerScreen extends StatefulWidget {
  const EventManagerScreen({Key? key}) : super(key: key);
  @override
  _EventManagerScreenState createState() => _EventManagerScreenState();
}

class _EventManagerScreenState extends State<EventManagerScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.85;
    return SafeArea(
        child: Center(
            child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text("Vos événements",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: centerLayoutHeight,
          color: primary_background,
          child: FutureBuilder<List<EventMod>>(
              future: getEvents(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<EventMod>> snapshot,
              ) {
                if (snapshot.hasData) {
                  List<EventMod> events = snapshot.data!;
                  return EventsListViewWidget(events, this);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ],
    )));
  }
}

class EventsListViewWidget extends StatelessWidget {
  final List<EventMod> events;
  final dynamic _listViewStateInstance;

  const EventsListViewWidget(this.events, this._listViewStateInstance,
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
                return EventListItem(events, index);
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
