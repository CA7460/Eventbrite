import 'package:event_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset(name),
              Text("Eventbrite", style: TextStyle(fontSize: 40),),
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, loginScreenRoute);
              } ,
              child: Text("Sign in")),
              TextButton(onPressed: _redirectEventbrite, child: Text("Don't have an eventbrite account? "))
            ],
          ),
        ),
      ),
    );
  }
}