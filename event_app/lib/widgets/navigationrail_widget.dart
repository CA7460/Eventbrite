import 'package:flutter/material.dart';

class NavigationTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationTestScreenState();
  }
}

class _NavigationTestScreenState extends State<NavigationTestScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          // This is the main content.
          Expanded(
            child: Container(
              color: Color(0xFF0C0C0C),
              child: Center(
                child: Text(
                  'selectedIndex: $_selectedIndex',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          NavigationRail(
            groupAlignment: -0.5,  //-1.0 = top, 1 = bottom
            backgroundColor: Color(0xFF101010),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.collections, color: Colors.black),
                selectedIcon: Icon(Icons.collections, color: Color(0xFF0033FF)),
                label: Text('Wall',
                  style: TextStyle(
                    color: Color(0xFF0033FF),
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.comment, color: Colors.black),
                selectedIcon: Icon(Icons.comment, color: Color(0xFF0033FF)),
                label: Text('Chat',
                  style: TextStyle(
                    color: Color(0xFF0033FF),
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.flare, color: Colors.black),
                selectedIcon: Icon(Icons.flare, color: Color(0xFF0033FF)),
                label: Text('Lights',
                  style: TextStyle(
                    color: Color(0xFF0033FF),
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.games, color: Colors.black),
                selectedIcon: Icon(Icons.games, color: Color(0xFF0033FF)),
                label: Text('games',
                  style: TextStyle(
                    color: Color(0xFF0033FF),
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.directions_car, color: Colors.black),
                selectedIcon:
                    Icon(Icons.directions_car, color: Color(0xFF0033FF)),
                label: Text('Carpool',
                  style: TextStyle(
                    color: Color(0xFF0033FF),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
