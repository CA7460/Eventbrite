import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/event_manager/models/eventmod.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final List<EventMod> events;
  final int index;
  const EventListItem(this.events, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
        color: Colors.deepOrange,
        borderOnForeground: true,
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              print("L'event " +
                  events[index].name +
                  " à été cliquer. Id:" +
                  events[index].eventid);
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