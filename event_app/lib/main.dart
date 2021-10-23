import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'config/routes/routes_handler.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? user = await getUser();
  final MyApp myapp = MyApp(
    //initialRoute: welcomeScreenRoute,
    initialRoute: user == null ? welcomeScreenRoute: eventManagerScreenRoute
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
        fontFamily: 'Roboto'
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
