// LE NAVIGATIONRAIL EST GÉRER PAR APP_FEATURE_MAIN_SCREEN.DART
// GARDER CE FICHIER POUR EXEMPLE, RÉFÉRENCE 

// import 'package:flutter/material.dart';
// import '../config/theme/colors.dart';

// class NavigationTestScreen extends StatefulWidget {
//   const NavigationTestScreen({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _NavigationTestScreenState();
//   }
// }

// class _NavigationTestScreenState extends State<NavigationTestScreen> {
//   // 0=main wall, 1=chatroom/msg, 2=Light effects, 3=crowd games, 4=Carpool
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: <Widget>[
//           // This is where feature content goes
//           // ...

//           Expanded(
//             child: Container(
//               color: primary_background,
//               child: Center(
//                 child: Text(
//                   'selectedIndex: $_selectedIndex',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           NavigationRail(
//             groupAlignment: -0.5, // De -1.0=top à 1=bottom
//             backgroundColor: navigationrail_background,
//             selectedIndex: _selectedIndex,
//             onDestinationSelected: (int index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             labelType: NavigationRailLabelType.selected,
//             destinations: const [
//               NavigationRailDestination(
//                 icon: Icon(Icons.collections, color: black),
//                 selectedIcon: Icon(Icons.collections, color: primary_blue),
//                 label: Text(
//                   'Wall',
//                   style: TextStyle(
//                     color: primary_blue,
//                   ),
//                 ),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.comment, color: black),
//                 selectedIcon: Icon(Icons.comment, color: primary_blue),
//                 label: Text(
//                   'Chat',
//                   style: TextStyle(
//                     color: primary_blue,
//                   ),
//                 ),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.flare, color: black),
//                 selectedIcon: Icon(Icons.flare, color: primary_blue),
//                 label: Text(
//                   'Lights',
//                   style: TextStyle(
//                     color: primary_blue,
//                   ),
//                 ),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.games, color: black),
//                 selectedIcon: Icon(Icons.games, color: primary_blue),
//                 label: Text(
//                   'games',
//                   style: TextStyle(
//                     color: primary_blue,
//                   ),
//                 ),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.directions_car, color: black),
//                 selectedIcon:
//                     Icon(Icons.directions_car, color: primary_blue),
//                 label: Text(
//                   'Carpool',
//                   style: TextStyle(
//                     color: primary_blue,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
