// import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:event_app/config/theme/colors.dart';
// import 'package:event_app/modules/app_features/crowd_games/local_widgets/actionchallenge_card.dart';
// import 'package:event_app/modules/app_features/crowd_games/local_widgets/photochallenge_card.dart';
// import 'package:event_app/modules/app_features/crowd_games/local_widgets/quiz_card.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/action_challenge.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/gamecount.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/gametype.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/photo_challenge.dart';
// import 'package:event_app/modules/app_features/crowd_games/models/quiz.dart';
// import 'package:event_app/utils/services/rest_api_service.dart';
// import 'package:event_app/utils/utils.dart';
// import 'package:event_app/widgets/primary_button_widget.dart';

// // Count how many games of each categories
// Future<List<GameCount>> getGameCounts() async {
//   var response = await getGameCountsFromDatabase();
//   print('gamecount stack');

//   if (response[0] == "OK" && response.length > 1) {
//     response.removeAt(0);
//     return response.map((e) => GameCount.fromJson(e)).toList();
//   }
//   return <GameCount>[];
// }

// // insert data in database and return final
// Future<CrowdGame> postLocalCrowdGame(CrowdGame localCrowdGame) async {
//   var response = await addCrowdGameInDatabase(localCrowdGame);
//   print('create crowdgame stack');
//   if (response[0] == "OK" && response.length > 1) {
//     //response.removeAt(0);
//     return CrowdGame.fromJson(response[1]);
//   }
//   return CrowdGame("", <GameManager>[]);
// }

// Future<List<GameManager>> postLocalGameManagers(
//     String crowdGameId, List<GameManager> gameManagers) async {
//   var response = await addGameManagersInDatabase(crowdGameId, gameManagers);
//   print('create gamemanager stack');
//   if (response[0] == "OK" && response.length > 1) {
//     response.removeAt(0);
//     return response.map((e) => GameManager.fromJson(e)).toList();
//   }
//   return <GameManager>[];
// }

// // Getters for each game categories
// Future<List<Quiz>> getQuizList() async {
//   var response = await getQuizzesFromDatabase();

//   if (response[0] == "OK" && response.length > 1) {
//     response.removeAt(0);
//     return response.map((e) => Quiz.fromJson(e)).toList();
//   }
//   return <Quiz>[];
// }

// Future<List<PhotoChallenge>> getPhotoChallengeList() async {
//   var response = await getPhotoChallengesFromDatabase();

//   if (response[0] == "OK" && response.length > 1) {
//     response.removeAt(0);
//     return response.map((e) => PhotoChallenge.fromJson(e)).toList();
//   }
//   return <PhotoChallenge>[];
// }

// Future<List<ActionChallenge>> getActionChallengeList() async {
//   var response = await getActionChallengesFromDatabase();

//   if (response[0] == "OK" && response.length > 1) {
//     response.removeAt(0);
//     return response.map((e) => ActionChallenge.fromJson(e)).toList();
//   }
//   return <ActionChallenge>[];
// }

// // Create a final GameSet with crowdgame and gamemanager data
// Future<List<Game>> composeGameSet(
//     CrowdGame completeCrowdGame, List<GameManager> completeGameManagers) async {
//   List<Quiz> quizzes = await getQuizList();
//   List<PhotoChallenge> photoChallenges = await getPhotoChallengeList();
//   List<ActionChallenge> actionChallenges = await getActionChallengeList();

//   List<Game> gameSet = <Game>[];
//   print('compose gameset stack');
//   for (GameManager gm in completeGameManagers) {
//     switch (gm.gameCategory) {
//       case GameType.quiz:
//         gameSet.add(quizzes[gm.gameId - 1]);
//         break;
//       case GameType.photoChallenge:
//         gameSet.add(photoChallenges[gm.gameId - 1]);
//         break;
//       case GameType.actionChallenge:
//         gameSet.add(actionChallenges[gm.gameId - 1]);
//         break;
//     }
//   }
//   return gameSet;
// }

// // Future<Game> composeGame(
// //     CrowdGame completeCrowdGame, List<GameManager> completeGameManagers) async {
// //   List<Quiz> quizzes = await getQuizList();
// //   List<PhotoChallenge> photoChallenges = await getPhotoChallengeList();
// //   List<ActionChallenge> actionChallenges = await getActionChallengeList();

// //   late Game game;

// //   for (GameManager gm in completeGameManagers) {
// //     switch (gm.gameCategory) {
// //       case GameType.quiz:
// //         game = quizzes[gm.gameId - 1];
// //         break;
// //       case GameType.photoChallenge:
// //         game = photoChallenges[gm.gameId - 1];
// //         break;
// //       case GameType.actionChallenge:
// //         game = actionChallenges[gm.gameId - 1];
// //         break;
// //     }
// //   }
// //   return game;
// // }

// // ============================================================
// // ======================= GAME SCREEN ========================
// // ============================================================

// class GameScreen extends StatefulWidget {
//   final String roomid;
//   const GameScreen({Key? key, required this.roomid}) : super(key: key);
//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   final ScrollController _scrollController = ScrollController();

//   late Future<List<Game>> _gameSetFuture;
//   late String _crowdGameId;
//   late String _gameStatus;
//   late bool _ongoingCrowdGame;
//   late Timer _everySecond;

//   int _secondsToGo = Game.timeAllowed;
//   String _now = Game.timeAllowed.toString();
//   bool _needToScroll = false;
//   int statementIndex = 0;
//   Timer? _timer;

//   // late String status;

//   @override
//   void initState() {
//     super.initState();
//     // status = GameStatus.ongoing;
    
//     _now = Game.timeAllowed.toString();
//     _gameSetFuture = createCrowdGame();
//     ,
//   }

//   void setGameStatusToOngoing() async {
//     var response =
//         await updateGameStatusInDatabase(_crowdGameId, GameStatus.ongoing);
//     print('gamestatus to ongoing stack');
//     if (response[0] == "OK" && response.length > 1) {
//       _ongoingCrowdGame = true;
//       // ***** var response2 = await updateGameRoomStatusInDatabase(); *******
//     } else {
//       _ongoingCrowdGame = false;
//     }
//   }

//   void updateSingleGameStatusToEnded(int index) async {
//     int stmt = index + 1;
//     print('about to end game no: ' + stmt.toString());
//     var response = await updateSingleGameStatusInDatabase(
//         _crowdGameId, stmt, GameStatus.ended);
//     if (response[0] == "OK" && response.length > 1) {
//       print(response[1]);
//     } else {
//       // _ongoingCrowdGame = false;
//     }
//   }

//   void updateRoomStatus(String status) async {
//     var response = await updateRoomStatusInDatabase(widget.roomid, status);
//     if (response[0] == "OK" && response.length > 1) {
//       print(response[1]);
//     } else {
//       // _ongoingCrowdGame = false;
//     }
//   }

//   void advanceToNextGame() async {
//     if (statementIndex != 0) {
//       _gameStatus = await getStatusInfo();
//       //status = GameStatus.ongoing;
//     }

//     print('delaying next statement');
//     print(_gameStatus);

//     if (statementIndex < (CrowdGame.statementCount - 1)) {
//       _timer = Timer(const Duration(seconds: Game.timeAllowed), () {
//         setState(() {
//           updateSingleGameStatusToEnded(statementIndex);
//           CrowdGame.gameListKey.currentState!.insertItem(statementIndex);
//           statementIndex++;
//           //status = GameStatus.ongoing;
//         });
//       });
//     } else {
//       updateSingleGameStatusToEnded(statementIndex);
//       updateRoomStatus(GameStatus.ended);
//     }

//     _needToScroll = true;
//   }

//   Future<String> getStatusInfo() async {
//     var response =
//         await getGameStatusFromDatabase(_crowdGameId, statementIndex + 1);
//     print('get statusinfo stack');
//     if (response[0] == "OK" && response.length > 1) {
//       print(response[1]);

//       return response[1].toString();
//     }
//     return "ERROR";
//   }

//   _scrollToEnd() async {
//     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 600), curve: Curves.linear);
//   }

//   Future<List<Game>> createCrowdGame() async {
//     List<GameCount> gameCounts = await getGameCounts();

//     CrowdGame localCrowdGame =
//         CrowdGame.composeCrowdGame(widget.roomid, gameCounts);

//     // Mettre un starting time à la premiere question!?
//     //localCrowdGame.gameManagers[0].startTime = DateTime.now();

//     // localCrowdGame.gameManagers[0].gameStatus = GameStatus.ongoing;
//     CrowdGame completeCrowdGame = await postLocalCrowdGame(localCrowdGame);

//     _crowdGameId = completeCrowdGame.crowdGameId;

//     List<GameManager> completeGameManager =
//         await postLocalGameManagers(_crowdGameId, localCrowdGame.gameManagers);

//     List<Game> gameSet =
//         await composeGameSet(completeCrowdGame, completeGameManager);

//     setGameStatusToOngoing();
//     _gameStatus = await getStatusInfo();

//     return gameSet;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final topLayoutHeight = screenSize.height * 0.1;
//     final centerLayoutHeight = screenSize.height * 0.75;
//     final bottomLayoutHeight = screenSize.height * 0.15;
//     Timer _timer;

//     if (_needToScroll) {
//       WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
//       _needToScroll = false;
//     }

//     return Center(
//       child: Column(
//         children: [
//           SizedBox(
//             height: topLayoutHeight,
//           ),
//           Container(
//             alignment: Alignment.topCenter,
//             height: centerLayoutHeight,
//             //key: _GameRoomListStateKey,
//             color: primary_background,
//             // child: Center(
//             child: FutureBuilder<List<Game>>(
//                 future: _gameSetFuture,
//                 builder: (
//                   BuildContext context,
//                   AsyncSnapshot<List<Game>> snapshot,
//                 ) {
//                   // if (snapshot.hasData) {
//                   //   final games = snapshot.data!;

//                   //   advanceToNextGame();

//                   //   return AnimatedList(
//                   //       key: CrowdGame.gameListKey,
//                   //       controller: _scrollController,
//                   //       initialItemCount: 1,
//                   //       itemBuilder: (context, index, animation) {
//                   //         switch (games[index].category) {
//                   //           case 'Quiz':
//                   //             return QuizCard(
//                   //                 games[index] as Quiz, index + 1, print, ());
//                   //           case 'Challenge':
//                   //             return ActionCard(
//                   //                 games[index] as ActionChallenge, index + 1);
//                   //           default:
//                   //             return PhotoHuntCard(
//                   //                 games[index] as PhotoChallenge, index + 1);
//                   //         }
//                   //       });
//                   //   //}
//                   // } else {
//                      return CircularProgressIndicator();
//                   // }
//                 }),
//             // ),
//           ),
//           Container(
//             height: bottomLayoutHeight,
//             padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
//             alignment: Alignment.topLeft,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text("Score",
//                     style: TextStyle(
//                         color: primary_pink,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Text("Player 1: 50 pts",
//                             style: TextStyle(
//                               color: primary_green,
//                               fontSize: 14,
//                             )),
//                         Text("Player 2: 200 pts",
//                             style: TextStyle(
//                               color: primary_green,
//                               fontSize: 14,
//                             )),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text("Player 3: 150 pts",
//                             style: TextStyle(
//                               color: primary_green,
//                               fontSize: 14,
//                             )),
//                         Text("Player 4: 50 pts",
//                             style: TextStyle(
//                               color: primary_green,
//                               fontSize: 14,
//                             )),
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



//       //Widget wrap pour slide transition animation
//       //return SlideTransition(
//       // Animation slide de gauche à droite
//       // position: Tween<Offset>(
//       //   begin: const Offset(-1,0),
//       //   end: Offset(0,0),
//       // ).animate(animation),
//       // ou
//       // Animation de gauche à droite avec ease
//       // position: animation.drive(
//       //     Tween(begin: Offset(3, 0.0), end: Offset(0.0, 0.0))
//       //         .chain(CurveTween(curve: Curves.elasticInOut))),
//       //child: Center...