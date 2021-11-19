import 'package:event_app/config/theme/colors.dart';
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
        margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
        color: eventbrite_red,
        borderOnForeground: true,
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              print("L'event " +
                  events[index].name +
                  " à été cliquer. Id:" +
                  events[index].eventid);

              //Provider a maintenant l'evenement en cours
              currentEvent.makeCurrentEvent(events[index]);
              attendees.loadAttendees(events[index].eventid);
              Utils.mainAppNav.currentState!.pushNamed(
                  appFeaturesMainScreenRoute,
                  arguments: events[index]);
              // Utils.mainAppNav.currentState!
              //     .pushNamed(carPoolListRoute, arguments: events[index]);
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(15, 4, 4, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          Text(events[index].location, //Mois de l'event
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                        ]),
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: Card(
                        color: textbox_background,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(nomDuMois(events[index].startTime.month),
                                style: TextStyle(
                                    color: primary_green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                            Text(
                                events[index]
                                    .startTime
                                    .day
                                    .toString(), //date event
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}

String nomDuMois(int month) {
  switch (month) {
    case 1:
      return "Janvier";

    case 2:
      return "Février";

    case 3:
      return "Mars";

    case 4:
      return "Avril";

    case 5:
      return "Mai";

    case 6:
      return "Juin";

    case 7:
      return "Juillet";

    case 8:
      return "Août";

    case 9:
      return "Septembre";

    case 10:
      return "Octobre";

    case 11:
      return "Novembre";

    case 12:
      return "Décembre";

    default:
      return "Erreur";
  }
}
