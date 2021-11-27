import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  //When the TextButton is pressed, opens browser to Eventbrite sign up page
  void _redirectEventbrite() async {
    const url = 'https://www.eventbrite.ca/signin/signup';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.4;
    final centerLayoutHeight = screenSize.height * 0.3;
    final bottomLayoutHeight = screenSize.height * 0.3;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primary_background,
        body: Column(
          children: [
            Container(
                height: topLayoutHeight,
                child: Image.asset('assets/images/welcome2.jpg')),
            Container(
              height: centerLayoutHeight,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Text(
                    "Briter",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: eventbrite_red,
                      letterSpacing: -2,
                      height: 0.1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                      ),
                      Text("by",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Image.asset(
                        'assets/images/eventbritelogo2.png',
                        height: 34,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Container(
            //   height: bottomLayoutHeight,
            //   alignment: Alignment.topCenter,
            //  child: 
              Column(
                children: [
                  PrimaryButton("Sign in", primary_blue, onPressed: () {
                    Utils.mainAppNav.currentState!.pushNamed(loginScreenRoute);
                  }),
                  TextButton(
                      onPressed: _redirectEventbrite,
                      child: Text(
                        "Don't have an eventbrite account? ",
                        style: TextStyle(color: primary_blue),
                      )),
                ],
              ),
            //),
          ],
        ),
      ),
    );
  }
}
