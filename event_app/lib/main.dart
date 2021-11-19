import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/models/attendee_list.dart';
import 'package:event_app/models/current_event.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_list.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/routes/routes_handler.dart' as router;
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black.withOpacity(0),
  ));
  final String? user = await getUser();
  //print(user);
  final MyApp myapp = MyApp(
      // Test pour Sam
       //initialRoute: appFeaturesMainScreenRoute,
      initialRoute: welcomeScreenRoute);
          // user == null ? welcomeScreenRoute : eventManagerScreenRoute);
  runApp(myapp);
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  MyApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoggedUser>(create: (_) => LoggedUser(),),
        ChangeNotifierProvider<CurrentEvent?>(create: (_) => CurrentEvent()),
        ChangeNotifierProvider<MessageList>(create: (_) => MessageList()),
        ChangeNotifierProvider<ConversationList>(create: (_) => ConversationList()),
        ChangeNotifierProvider<AttendeeList>(create: (_) => AttendeeList())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Utils.mainAppNav,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        onGenerateRoute: router.generateRoute,
        initialRoute: initialRoute,
      )
    );
  }
}
