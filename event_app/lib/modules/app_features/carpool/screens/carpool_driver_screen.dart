import 'package:event_app/models/eventmod.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/user_person.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/scoreboard_screen.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/modules/app_features/carpool/screens/carpool_passenger_screen.dart';

import 'carpool_list_screen.dart';

Future navigerEcrans(context, ecran) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ecran));
}

class CarpoolDriverScreen extends StatefulWidget {
  final EventMod event;
  const CarpoolDriverScreen({Key? key, required this.event}) : super(key: key);

  @override
  _CarpoolDriverScreenState createState() => _CarpoolDriverScreenState(event);
}

class _CarpoolDriverScreenState extends State<CarpoolDriverScreen> {
  final EventMod event;
  late Future<UserPerson> _userPerson;

  _CarpoolDriverScreenState(this.event);

  @override
  void initState() {
    super.initState();
    _userPerson = getCarPoolUser();
  }

  void refreshCarPoolList() {
    setState(() {
      _userPerson = getCarPoolUser();
    });
  }

  Future<UserPerson> getCarPoolUser() async {
    var response = await getCarPoolUserFromDatabase();
    if (response[0] == "OK" && response.length > 1) {
      response.removeAt(0);
      return UserPerson.fromJson(response[0]);
    }
    return UserPerson('','','','','');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidthForCard = screenWidth / 2;
    final cardSize = maxWidthForCard - 20;
    final labelWidth = cardSize - 26;

    return Container(
      child: FutureBuilder<UserPerson>(
        future: _userPerson,
          builder: (
              BuildContext context,
              AsyncSnapshot<UserPerson> snapshot
          )
          {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return SafeArea(
                child: Scaffold(
                  body: Form(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 5, top: 5),
                            child: PrimaryButton2("",primary_blue,
                                onPressed: () => {
                                  // navigerEcrans(context, CarpoolPassengerScreen())
                                  // Utils.carpoolNav.currentState!
                                  //     .pushNamed(carPoolPassengerRoute)
                                }),
                          ),

                           SizedBox(
                            height: 0,
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title:  Text(user.firstName + " " + user.lastName,
                              style: TextStyle(
                              fontSize: 18,
                                color: Color(0xFF1E84D5),
                              //fontWeight: FontWeight.w600,
                            ),),
                            subtitle: const Text("driver's name"),
                          ),
                          SizedBox(height: 0,
                          ),
                          ListTile(
                            leading: const Icon(Icons.label),
                            title:  Text(event.name,
                              style: TextStyle(
                                fontSize: 18,
                                //color: Color(0xFF6B6FB6),
                                color: Color(0xFF1E84D5),
                                //fontWeight: FontWeight.w600,
                              ),),
                            subtitle: const Text("event's name"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_city),
                            title:  Text(event.city + ",\n" + event.location,
                              style: TextStyle(
                                fontSize: 18,
                                //color: Color(0xFF6B6FB6),
                                color: Color(0xFF1E84D5),
                                //fontWeight: FontWeight.w600,
                              ),),
                           // subtitle: const Text("city"),
                            subtitle: Text(event.streetNumber.toString() + ' ' + event.streetName),
                          ),
                          ListTile(
                            //leading: const Icon(Icons.access_time_filled),
                              leading: const Icon(  Icons.today),
                            title:  Text(event.startTime.year.toString() + "-" +
                                event.startTime.month.toString() + "-" +
                                event.startTime.day.toString() + "\n" +
                                event.startTime.hour.toString() + ":" +
                                event.startTime.minute.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                //color: Color(0xFF6B6FB6),
                                color: Color(0xFF1E84D5),
                                //fontWeight: FontWeight.w600,
                              ),),
                            subtitle: const Text("event's date & time"),
                          ),

                          ListTile(
                            leading: const Icon(Icons.add_location_alt),
                            title: TextFormField(
                              //  controller: nameController,
                              onChanged: (value) {
                                // _exercice.name = nameController.text;
                              },
                              validator: (value) {
                                if (value != "") {
                                  return value!.length < 30
                                      ? null
                                      : 'Maximum 30 caractères';
                                } else if (value!.contains(RegExp(r'[0-9]'))) {
                                  return 'Le nom ne doit pas contenir de chiffre';
                                } else {
                                  return 'Entrer un nom';
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Pick up address:",
                             //   labelText: 'Pick up address: ',
                                errorStyle: TextStyle(
                                  color: Color(0xFF2195F2),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          // ===========  =================
                          ListTile(
                            leading: const Icon(Icons.access_time_outlined),
                            title: TextFormField(
                              //  controller: nameController,
                              onChanged: (value) {
                                // _exercice.name = nameController.text;
                              },
                              validator: (value) {
                                if (value != "") {
                                  return value!.length < 30
                                      ? null
                                      : 'Maximum 30 caractères';
                                } else if (value!.contains(RegExp(r'[0-9]'))) {
                                  return 'Le nom ne doit pas contenir de chiffre';
                                } else {
                                  return 'Entrer un nom';
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Pick up time:",
                                //   labelText: 'Pick up address: ',
                                errorStyle: TextStyle(
                                  color: Color(0xFF2195F2),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),

                          // ===========  =================
                          ListTile(
                            leading: const Icon(Icons.add_reaction),
                            title: TextFormField(
                              //  controller: nameController,
                              onChanged: (value) {
                                // _exercice.name = nameController.text;
                              },
                              validator: (value) {
                                if (value != "") {
                                  return value!.length < 30
                                      ? null
                                      : 'Maximum 30 caractères';
                                } else if (value!.contains(RegExp(r'[0-9]'))) {
                                  return 'Le nom ne doit pas contenir de chiffre';
                                } else {
                                  return 'Entrer un nom';
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Number of available seats: ",
                                //   labelText: 'Pick up address: ',
                                errorStyle: TextStyle(
                                  color: Color(0xFF2195F2),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),

                          // ===========  =================
                          Padding(
                            padding: EdgeInsets.only(bottom: 5, top: 35),
                            child: Row(
                              children: <Widget>[
                                Visibility(
                                  //      visible: _isModificationButtonVisible,
                                  child: Expanded(
                                    child: RaisedButton(
                                      color: Color(0xFF2195F2),
                                      textColor: Colors.white,
                                      child: Text(
                                        'Add route',
                                        textScaleFactor: 1.5,
                                      ),
                                      onPressed: () async {
                                        //     String reponse = await this
                                        //          ._enregistrerChangements('modifier');
                                        //     Navigator.pop(context, reponse);
                                      },
                                    ),
                                  ),
                                ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: primary_blue),
              );
            }
          }
      )
    );
  }
}