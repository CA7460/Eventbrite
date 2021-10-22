import 'package:event_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'config/routes/routes_handler.dart' as router;
import 'package:google_fonts/google_fonts.dart';

void main() async {
  //final String? user = await getUser();
  final MyApp myapp = MyApp(
    initialRoute: welcomeScreenRoute,
    //initialRoute: user == null ? WelcomeScreenRoute: EventManagerScreenRoute
  );
  runApp(myapp);
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  MyApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,    
        ),
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
