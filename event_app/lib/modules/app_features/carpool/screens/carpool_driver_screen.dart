import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/user_person.dart';
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
  const CarpoolDriverScreen({Key? key}) : super(key: key);
  @override
  _CarpoolDriverScreenState createState() => _CarpoolDriverScreenState();
}

class _CarpoolDriverScreenState extends State<CarpoolDriverScreen> {
  late Future<UserPerson> _userPerson;

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
    var eventName = 'Event name: "The Lumineers"';
    _userPerson.then((value) => eventName = value.lastName);
    final city = 'City: Montreal';

    final place = 'Place: Centre Bell';
    final address = 'Address: ';
    final dateTime = 'Event\'s Date and time: ';

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
                            height: 25,
                          ),
                          Text(
                            user.lastName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$city',
                            style: TextStyle(
                              fontSize: 18,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$place',
                            style: TextStyle(
                              fontSize: 18,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$address',
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$dateTime',
                            style: TextStyle(
                              fontSize: 18,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
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
                                labelText: 'Pick up address: ',
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          // ===========  =================
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              //    controller: shortDescController,
                              onChanged: (value) {
                                //    _exercice.description = shortDescController.text;
                              },
                              validator: (value) {
                                if (value == "") {
                                  return 'Entrer une courte description';
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Pick up date and time: ',
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          // ===========  =================
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              // controller: longDescController,
                              onChanged: (value) {
                                //    _details.longDescription = longDescController.text;
                              },
                              validator: (value) {
                                if (value == "") {
                                  return 'Entrer une description détaillée';
                                }
                              },
                              // keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Number of available seats: ',
                                //   hintText: 'Maximum 300 caractères',
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
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