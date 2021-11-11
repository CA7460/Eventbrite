import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/create_game_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/loading_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/ongoing_game_screen.dart';
import 'package:event_app/modules/event_manager/models/eventmod.dart';
import 'package:event_app/modules/event_manager/screens/event_manager_screen.dart';
import 'package:event_app/modules/login/screens/login_screen.dart';
import 'package:event_app/modules/login/screens/welcome_screen.dart';
import 'package:event_app/modules/app_features/app_features_main_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/gameroom_list_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/gameroom_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/game_screen.dart';
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
      return MaterialPageRoute(builder: (context) => AppFeaturesMainScreen(event: settings.arguments as EventMod));

    // Test pour Sam - crowdGames
    // case crowdGamesLandingScreenRoute:
    //   return MaterialPageRoute(builder: (context) => CrowdGameLandingScreen());
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

// NESTED NAVIGATOR pour le navigation Rail, landing screen de chaque feature
Route<dynamic> generateAppFeatureRoute(RouteSettings settings) {
  switch (settings.name) {
    // main wall
    // messenger
    // lights
    case gameRoomListRoute:
      return MaterialPageRoute(builder: (context) => GameRoomListScreen());
    // carpool
    default: // PENSER À QQCHOSE POUR DEFAULT
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

// Navigations individuelles pour chaque feature

// generateMainWallRoute...
// generateMessengerRoute...
// generateLightEffectsRoute...

Route<dynamic> generateGameRoute(RouteSettings settings) {
  switch (settings.name) {
    case gameRoomListRoute:
      return MaterialPageRoute(builder: (context) => GameRoomListScreen());
    case enterGameRoomRoute:
      return MaterialPageRoute(
          builder: (context) =>
              GameRoomScreen(gameroom: settings.arguments as GameRoom));
    case createGameRoute:
      return MaterialPageRoute(builder: (context) => CreateGameScreen());
    // case startNewGameRoute:
    //   return MaterialPageRoute(builder: (context) => GameScreen(roomid: settings.arguments as String));
    case startNewGameRoute:
      return MaterialPageRoute(builder: (context) => LoadingScreen(roomid: settings.arguments as String));

    case joinGameRoute:
      return MaterialPageRoute(
          builder: (context) => 
              OngoingGameScreen(roomid: settings.arguments as String));
    case scoreboardRoute:
      return MaterialPageRoute(builder: (context) => ScoreboardScreen());

    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

// Route<dynamic> generateCarpoolRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case carpoolListRoute:
//       return MaterialPageRoute(builder: (context) => CarPoolListScreen());

//   // Autres routes possible à l'intérieur du feature

//     default:
//   }
// }

// MESSENGER ...
