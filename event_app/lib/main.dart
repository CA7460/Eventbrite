import 'package:flutter/material.dart';
import 'package:event_app/widgets/navigationrail_widget.dart';

void main() {
  runApp(const MyApp());
}

Widget homePage() {
//  return const Text('test');

// Si le user est déja inscrit, direction vers la liste 'devents (module event_manager)
// si l'app est ouverte pour la première fois, direction login form (module login)

// Module login à élaborer dans les dossiers appropriés
// Ne pas oublier de l'importer ici
//  return loginScreen();
  return NavigationTestScreen();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: homePage(),
        ),
      ),
    );
  }
}
