import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class LightEffectScreen extends StatefulWidget {
  const LightEffectScreen({Key? key}) : super(key: key);
  @override
  _LightEffectState createState() => _LightEffectState();
}

class _LightEffectState extends State<LightEffectScreen> {
  String _selectedImage = 'assets/images/lighter.gif';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Expanded(
        child: Column(
      children: [
        Text("Light effect",
            style: TextStyle(color: primary_blue, fontSize: 20)),
        Image.asset(
          _selectedImage,
          height: screenSize.height * 0.85,
          fit: BoxFit.cover,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          buttonPadding: EdgeInsets.all(2),
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  fixedSize: Size(30, 30),
                  shape: CircleBorder(),
                  side: BorderSide(width: 5, color: navigationrail_background),
                ),
                onPressed: () {
                  setState(() {
                    _selectedImage = 'assets/images/blue.jpg';
                  });
                },
                child: null),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: Size(30, 30),
                  shape: CircleBorder(),
                  side: BorderSide(width: 5, color: navigationrail_background),
                ),
                onPressed: () {
                  setState(() {
                    _selectedImage = 'assets/images/white.jpg';
                  });
                },
                child: null),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  fixedSize: Size(30, 30),
                  shape: CircleBorder(),
                  side: BorderSide(width: 5, color: navigationrail_background),
                ),
                onPressed: () {
                  setState(() {
                    _selectedImage = 'assets/images/red.jpg';
                  });
                },
                child: null),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                fixedSize: Size(30, 30),
                shape: CircleBorder(),
                side: BorderSide(width: 5, color: navigationrail_background),
              ),
              onPressed: () {
                setState(() {
                  _selectedImage = 'assets/images/lighter.gif';
                });
              },
              child: Image.asset(
                'assets/images/lighter.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                fixedSize: Size(30, 30),
                shape: CircleBorder(),
                side: BorderSide(width: 5, color: navigationrail_background),
              ),
              onPressed: () {
                setState(() {
                  _selectedImage = 'assets/images/rainbow.gif';
                });
              },
              child: Image.asset(
                'assets/images/rainbow.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
      ],
    ));
  }
}
