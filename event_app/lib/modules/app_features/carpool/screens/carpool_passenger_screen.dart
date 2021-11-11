import 'package:event_app/modules/app_features/carpool/local_widgets/carpool_list_item.dart';
import 'package:event_app/modules/app_features/carpool/models/carpool.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/modules/app_features/carpool/screens/carpool_driver_screen.dart';

Future navigerEcrans(context, ecran) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ecran));
}

class CarpoolPassengerScreen extends StatelessWidget {

  CarpoolPassengerScreen();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidthForCard = screenWidth / 2;
    final cardSize = maxWidthForCard - 20;
    final labelWidth = cardSize - 26;

    return InkWell(

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
                    image: AssetImage("assets/images/eventbrite_welcome.jpg"),
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
                  child: Text("TEST TEST",
                      style: TextStyle(
                          fontSize: 16, color: Color(0xffc8f1f1)),
                      textAlign: TextAlign.center),
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }
}



