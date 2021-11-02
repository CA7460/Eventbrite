import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/models/action_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/game.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamecount.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamemanager.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gametype.dart';
import 'package:event_app/modules/app_features/crowd_games/models/photo_challenge.dart';
import 'package:event_app/modules/app_features/crowd_games/models/quiz.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

// CHECK:Créer un supermodel Game, et 3 sous-model quiz, photo, action
// Faire 3 call vers la database pour remplir 3 arrays de games
// Créer un model CrowdGameManager
// Créer des constantes de jeux (nb de questions, temps alloués ect. voir diagrammes)
// Dans un loop == nb de questions, générer des nombre aléatoire entre 1 et 3 pour déterminer quel array de jeux prendre
// Et créer un nombre aléatoir entre 1 et le nb d'élem dans l'array de jeux
// Ajouter les détails du jeux dans le CrowdGameManager
// Une fois les 10 jeux choisis, ajouter à la database

// Future<List<Object>> getData(String type) async {

//   var response;
//   var object;

//   switch (type) {
//     case 'quiz':
//     response = await getQuizzesFromDatabase();
//     object = Quiz;
//     break;
//     case 'photo':
//     response = await getPhotoChallengesFromDatabase();
//     object = PhotoChallenge;
//     break;
//     case 'action':
//     response = await getActionChallengesFromDatabase();
//     object = ActionChallenge;
//     break;
//   }

//   if (response[0] == "OK" && response.length > 1) {
//     response.removeAt(0);
//     return response.map((e) => object.fromJson(e)).toList();
//   }
// return <Object>[];
// }

// Count how many games of each categories
Future<List<GameCount>> getGameCounts() async {
  var response = await getGameCountsFromDatabase();

  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => GameCount.fromJson(e)).toList();
  }
  return <GameCount>[];
}

// insert data in database and return final
Future<CrowdGame> postLocalCrowdGame(CrowdGame localCrowdGame) async {
  var response = await addCrowdGameInDatabase(localCrowdGame);

  if (response[0] == "OK" && response.length > 1) {
    //response.removeAt(0);
    return CrowdGame.fromJson(response[1]);
  }
  return CrowdGame("", <GameManager>[]);
}

Future<List<GameManager>> postLocalGameManagers(
    String crowdGameId, List<GameManager> gameManagers) async {
  var response = await addGameManagersInDatabase(crowdGameId, gameManagers);

  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => GameManager.fromJson(e)).toList();
  }
  return <GameManager>[];
}

// Getters for each game categories
Future<List<Quiz>> getQuizList() async {
  var response = await getQuizzesFromDatabase();

  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => Quiz.fromJson(e)).toList();
  }
  return <Quiz>[];
}

Future<List<PhotoChallenge>> getPhotoChallengeList() async {
  var response = await getPhotoChallengesFromDatabase();

  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => PhotoChallenge.fromJson(e)).toList();
  }
  return <PhotoChallenge>[];
}

Future<List<ActionChallenge>> getActionChallengeList() async {
  var response = await getActionChallengesFromDatabase();

  if (response[0] == "OK" && response.length > 1) {
    response.removeAt(0);
    return response.map((e) => ActionChallenge.fromJson(e)).toList();
  }
  return <ActionChallenge>[];
}

// Create a final GameSet with crowdgame and gamemanager data
Future<List<Game>> composeGameSet(
    CrowdGame completeCrowdGame, List<GameManager> completeGameManagers) async {
  List<Quiz> quizzes = await getQuizList();
  List<PhotoChallenge> photoChallenges = await getPhotoChallengeList();
  List<ActionChallenge> actionChallenges = await getActionChallengeList();

  List<Game> gameSet = <Game>[];

  for (GameManager gm in completeGameManagers) {
    switch (gm.gameCategory) {
      case GameType.quiz:
        gameSet.add(quizzes[gm.gameId - 1]);
        break;
      case GameType.photoChallenge:
        gameSet.add(photoChallenges[gm.gameId - 1]);
        break;
      case GameType.actionChallenge:
        gameSet.add(actionChallenges[gm.gameId - 1]);
        break;
    }
  }
  return gameSet;
}

// ============================================================
// ======================= GAME SCREEN ========================
// ============================================================

class GameScreen extends StatefulWidget {
  final String roomid;
  const GameScreen({Key? key, required this.roomid}) : super(key: key);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Future<List<Game>> _gameSetFuture;

  // initialiser index question initiale à 0, current pos
  @override
  void initState() {
    super.initState();
    print('about to create crowdgame');
    _gameSetFuture = createCrowdGame();
  }

  void nextGame() {
    print('show next statement');
    setState(() {
      //_gameroomFuture = getGameRooms();
    });
  }

  Future<List<Game>> createCrowdGame() async {
    // List<Quiz> quizzes = await getQuizList();
    // List<PhotoChallenge> photoChallenges = await getPhotoChallengeList();
    // List<ActionChallenge> actionChallenges = await getActionChallengeList();

    List<GameCount> gameCounts = await getGameCounts();

    // CrowdGame localCrowdGame =
    //     CrowdGame.composeCrowdGame(quizzes, photoChallenges, actionChallenges);

    CrowdGame localCrowdGame =
        CrowdGame.composeCrowdGame(widget.roomid, gameCounts);

    // Mettre un starting time à la premiere question!?
    localCrowdGame.gameManagers[0].startTime = DateTime.now();
    CrowdGame completeCrowdGame = await postLocalCrowdGame(localCrowdGame);
    print(completeCrowdGame.crowdGameId);
    List<GameManager> completeGameManager = await postLocalGameManagers(
        completeCrowdGame.crowdGameId, localCrowdGame.gameManagers);

    List<Game> gameSet =
        await composeGameSet(completeCrowdGame, completeGameManager);

    return gameSet;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.65;
    final bottomLayoutHeight = screenSize.height * 0.25;
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: topLayoutHeight,
            child: GestureDetector(
                onTap: () {
                  print("refresh btn pressed");
                  // refreshGameRoomList();
                },
                child: Text("Refresh list",
                    style: TextStyle(color: primary_blue))),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: centerLayoutHeight,
            //key: _GameRoomListStateKey,
            color: primary_background,
            // child: Center(
            child: FutureBuilder<List<Game>>(
                future: _gameSetFuture,
                // future: getGameRooms(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Game>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final games = snapshot.data!;
                    return Center(
                      child: Text(
                          'FYCK YEAH\n' +
                              games[0].statement +
                              "\n" +
                              games[1].statement ,
                              // "\n" +
                              // games[2].statement +
                              // "\n" +
                              // games[3].statement +
                              // "\n" +
                              // games[4].statement +
                              // "\n" +
                              // games[5].statement +
                              // "\n" +
                              // games[6].statement +
                              // "\n" +
                              // games[7].statement +
                              // "\n" +
                              // games[8].statement +
                              // "\n" +
                              // games[9].statement,
                          style: TextStyle(color: Colors.white)),
                    );

                    // GameRoomListViewWidget(refreshGameRoomList, items, this);
                    // List<GameRoom> gamerooms = snapshot.data!;
                    // return GameRoomListViewWidget(gamerooms, this);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            // ),
          ),
          Container(
            height: bottomLayoutHeight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryButton('Create game', primary_blue,
                    onPressed: () =>
                        // {Navigator.pushNamed(context, enterGameRoomRoute)}),
                        {
                          // Utils.appFeaturesNav
                          //     .currentState! // pushReplacementNamed remplace la route, on ne peut pas back dessus
                          //     .pushNamed(createGameRoute)
                          //     .then((value) {
                          //   refreshGameRoomList();
                          // }) // pushNamed permet de pop()
                          //  AJOUTER UNE NOUVELLE ROUTE POUR CREATE GAME
                        }),
                PrimaryButton('Scoreboard', primary_blue,
                    onPressed: () => {
                          // Utils.appFeaturesNav.currentState!
                          //     .pushNamed(scoreboardRoute)
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
