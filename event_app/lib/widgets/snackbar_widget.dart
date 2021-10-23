import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/config/theme/styles.dart';

enum SnackBarType { 
  welcome, 
  mainWall, 
  messenger, 
  ligths, 
  crowdGame, 
  carpool
}

Icon getIcon(SnackBarType sbType) {
  switch (sbType) {
    case SnackBarType.welcome:
      return Icon(Icons.beenhere, color: primary_green);
    case SnackBarType.mainWall:
      return Icon(Icons.collections, color: primary_green);
    case SnackBarType.messenger:
      return Icon(Icons.comment, color: primary_green);
    case SnackBarType.ligths:
      return Icon(Icons.flare, color: primary_green);
    case SnackBarType.crowdGame:
      return Icon(Icons.games, color: primary_green);
    case SnackBarType.carpool:
      return Icon(Icons.directions_car, color: primary_green);
  }
}

// Prévoir d'ajouter une action lorsqu'on tap pour être redirigé

// ignore: non_constant_identifier_names
SnackBar EventSnackBar(String sbText, SnackBarType sbType) {
    return SnackBar(
      backgroundColor: textbox_background,
      content: Row(
        children: <Widget>[
          getIcon(sbType),
          SizedBox(
            width: 12,
          ),
          Text(sbText, style: snackBarStyle),
        ],
      ),
      duration: const Duration(seconds: 3),
      // action: SnackBarAction(
      //   label: 'ACTION',
      //   onPressed: () {},
      // ),
    );
  }


// class EventSnackBar extends StatelessWidget {
//   final String sbText;
//   final SnackBarType sbType;

//   const EventSnackBar({Key? key, required this.sbText, required this.sbType})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       backgroundColor: textbox_background,
//       content: Row(
//         children: <Widget>[
//           getIcon(sbType),
//           Text(sbText, style: snackBarStyle),
//         ],
//       ),
//       duration: const Duration(seconds: 3),
//       // action: SnackBarAction(
//       //   label: 'ACTION',
//       //   onPressed: () {},
//       // ),
//     );
//   }
// }