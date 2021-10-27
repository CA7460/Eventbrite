import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/modules/event_manager/screens/event_manager_screen.dart';
import 'package:event_app/modules/login/screens/login_screen.dart';
import 'package:event_app/modules/login/screens/welcome_screen.dart';
import 'package:event_app/modules/app_features/app_features_main_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/gameroom_list_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/gameroom_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/scoreboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeScreenRoute:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case eventManagerScreenRoute:
      return MaterialPageRoute(builder: (context) => EventManagerScreen());
    case appFeaturesMainScreenRoute:
      return MaterialPageRoute(builder: (context) => AppFeaturesMainScreen());

    // Test pour Sam - crowdGames
    // case crowdGamesLandingScreenRoute:
    //   return MaterialPageRoute(builder: (context) => CrowdGameLandingScreen());
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

// NESTED NAVIGATOR pour le navigation Rail
Route<dynamic> generateAppFeatureRoute(RouteSettings settings) {
  switch (settings.name) {
    // main wall
    // messenger
    // lights
    
    // case crowdGamesLandingScreenRoute:
    //   return MaterialPageRoute(builder: (context) => GameRoomListScreen());
    
    case gameRoomListRoute:
      return MaterialPageRoute(builder: (context) => GameRoomListScreen());

    // carpool
    // ON MET QUOI COMME DEFAULT??  
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}


// Navigations individuelles pour chaque feature, bonne idée??
// Exemple pour crowd Games, génère plusieurs écrans, il faut back au bonnes places
// semble fonctionner
Route<dynamic> generateGameRoute(RouteSettings settings) {
  switch (settings.name) {
    case gameRoomListRoute:
      return MaterialPageRoute(builder: (context) => GameRoomListScreen());
    case enterGameRoomRoute:
      return MaterialPageRoute(builder: (context) => GameRoomScreen());
    case scoreboardRoute:
      return MaterialPageRoute(builder: (context) => ScoreboardScreen());
    // case joinGameRoute:
    //  return MaterialPageRoute(builder: (context) => GameScreen());
    
    // ENLEVER LE DEFAULT OU QQCHOSE 
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

// exemple pour carpool
// Route<dynamic> generateCarpoolRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case carpoolListRoute:
//       return MaterialPageRoute(builder: (context) => CarPoolListScreen());
  
//   // Autres routes possible à l'intérieur du feature 

//     default:
      
//   }
// }
