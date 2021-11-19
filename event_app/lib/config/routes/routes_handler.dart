import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gameroom.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/create_game_screen.dart';
import 'package:event_app/modules/app_features/discussion/models/chat_screen_argument.dart';
import 'package:event_app/modules/app_features/discussion/models/new_message_screen_argrument.dart';
import 'package:event_app/modules/app_features/discussion/screens/chat_screen.dart';
import 'package:event_app/modules/app_features/discussion/screens/main_messenger_screen.dart';
import 'package:event_app/modules/app_features/discussion/screens/new_message_screen.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/loading_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/ongoing_game_screen.dart';
import 'package:event_app/modules/app_features/light_effects/screens/light_effect_screen.dart';
import 'package:event_app/modules/app_features/main_wall/screens/main_wall_screen.dart';
// import 'package:event_app/modules/event_manager/models/eventmod.dart';
import 'package:event_app/modules/event_manager/screens/event_manager_screen.dart';
import 'package:event_app/modules/login/screens/login_screen.dart';
import 'package:event_app/modules/login/screens/welcome_screen.dart';
import 'package:event_app/modules/app_features/app_features_main_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/gameroom_list_screen.dart';
import 'package:event_app/modules/app_features/crowd_games/screens/gameroom_screen.dart';
// import 'package:event_app/modules/app_features/crowd_games/screens/game_screen.dart';
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
      return MaterialPageRoute(
          builder: (context) =>
              AppFeaturesMainScreen(event: settings.arguments as EventMod));

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
    case messengerLandingScreenRoute:
      return MaterialPageRoute(builder: (context) => MainMessengerScreen());
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
      return MaterialPageRoute(
          builder: (context) =>
              LoadingScreen(roomid: settings.arguments as String));

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
Route<dynamic> generateMessengerRoute(RouteSettings settings) {
  switch (settings.name) {
    case chatScreenRoute:
      return MaterialPageRoute(builder: (context) {
        ChatScreenArgument arguments = settings.arguments as ChatScreenArgument;
        return ChatScreen(socket: arguments.socket, conversation: arguments.conversation);
      });
    case messengerLandingScreenRoute:
      return MaterialPageRoute(builder: (context) => MainMessengerScreen());
    case newMessageRoute:
      return MaterialPageRoute(builder: (context) {
        NewMessageScreenArgument arguments =
            settings.arguments as NewMessageScreenArgument;
        return NewMessageScreen(socket: arguments.socket);
      });
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

//lightEffect route
Route<dynamic> generateLightEffectsRoute(RouteSettings settings) {
  switch (settings.name) {
    case lightEffectsRoute:
      return MaterialPageRoute(builder: (context) => LightEffectScreen());
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

//mainWall route
Route<dynamic> generateMainWallRoute(RouteSettings settings) {
  switch (settings.name) {
    case mainWallRoute:
      return MaterialPageRoute(builder: (context) => MainWallScreen());
    default:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}
