import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/services.dart';
import 'config/routes/routes_handler.dart' as router;
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black.withOpacity(0),
  ));
  final String? user = await getUser();
  final MyApp myapp = MyApp(
    // Test pour Sam
    // initialRoute: appFeaturesMainScreenRoute,
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
      navigatorKey: Utils.mainAppNav,
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
