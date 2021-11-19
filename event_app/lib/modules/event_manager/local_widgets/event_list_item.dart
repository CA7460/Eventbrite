import 'package:event_app/models/attendee_list.dart';
import 'package:event_app/models/current_event.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListItem extends StatelessWidget {
  final List<EventMod> events;
  final int index;
  const EventListItem(this.events, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrentEvent currentEvent = Provider.of<CurrentEvent>(context);
    final AttendeeList attendees = Provider.of<AttendeeList>(context);
    return Card(
        margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
        color: Colors.deepOrange,
        borderOnForeground: true,
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              // print("L'event " +
              //     events[index].name +
              //     " à été cliquer. Id:" +
              //     events[index].eventid
              // );
              //Provider a maintenant l'evenement en cours
              currentEvent.makeCurrentEvent(events[index]);
              attendees.loadAttendees(events[index].eventid);
              Utils.mainAppNav.currentState!.pushNamed(appFeaturesMainScreenRoute, arguments: events[index]);
            },
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(events[index].name, //nom event
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(events[index].city, //Ville de l'event
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    Text(
                        events[index].startTime.year.toString() +
                            "/" +
                            events[index].startTime.month.toString() +
                            "/" +
                            events[index]
                                .startTime
                                .day
                                .toString(), //Mois de l'event
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ]),
            )));
  }
}
