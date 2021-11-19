import 'dart:developer';

import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/crowd_games/models/crowdgame.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamecount.dart';
import 'package:event_app/modules/app_features/crowd_games/models/gamestatus.dart';
import 'package:event_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:event_app/modules/app_features/crowd_games/repositories/service_call.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  final String roomid;
  const LoadingScreen({required this.roomid, Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late String _crowdGameId;

  @override
  void initState() {
    super.initState();
    createCrowdGame();
    updateRoomStatus(widget.roomid, GameStatus.ongoing);
  }

  void removeMeAsPlayer() async {
    await removeMeFromPlayerManager();
  }

  enterOngoingGame() {
    Utils.crowdGameNav.currentState!
        .pushReplacementNamed(joinGameRoute, arguments: widget.roomid)
        .then((value) {
      removeMeAsPlayer();
    });
  }

  Future<void> createCrowdGame() async {
    List<GameCount> gameCounts = await getGameCounts();

    CrowdGame localCrowdGame =
        CrowdGame.composeCrowdGame(widget.roomid, gameCounts);

    // Mettre un starting time à la premiere question!?
    // localCrowdGame.gameManagers[0].startTime = DateTime.now();

    // Update le status une game à la fois?
    // localCrowdGame.gameManagers[0].gameStatus = GameStatus.ongoing;
    CrowdGame completeCrowdGame = await postLocalCrowdGame(localCrowdGame);

    _crowdGameId = completeCrowdGame.crowdGameId;

    await postLocalGameManagers(_crowdGameId, localCrowdGame.gameManagers);

    await updateGameManagersStatusToOngoing(_crowdGameId, GameStatus.ongoing);

    // test pour exfocus
    await getFullUrlListString();

    enterOngoingGame();
  }

  // Test pour ezfocus
  Future<String> getFullUrlListString() async {
    var urlCalgary = Uri.parse(
        "https://spiritleaf.ca/wp-admin/admin-ajax.php?action=store_search&lat=51.04473309999999&lng=-114.0718831&max_results=100&search_radius=3000");
    var urlMontreal = Uri.parse(
        "https://spiritleaf.ca/wp-admin/admin-ajax.php?action=store_search&lat=45.5016889&lng=-73.567256&max_results=100&search_radius=3000");

    var responseCalgary = await http.get(urlCalgary);
    var responseMontreal = await http.get(urlMontreal);

    String combinedResponse = responseCalgary.body + responseMontreal.body;

    List<String> tempArray = combinedResponse.split(".js");
    tempArray.removeLast();
    List<String> storeIDs = <String>[];

    const before = "embedded-menu\\" + "/";
    int startIndex, endIndex;

    for (String e in tempArray) {
      startIndex = e.indexOf(before) + before.length;
      endIndex = e.length;
      storeIDs.add(e.substring(startIndex, endIndex));
    }

    // Enlever les doublons
    final uniqueStoreIDs = storeIDs.toSet().toList();

    log(uniqueStoreIDs.toString());
    print(uniqueStoreIDs.length);

    // ============================================================
    // =============== Construire les URL request =================
    // ============================================================

    const collections = [
      "Flower",
      "Pre-Rolls",
      "Vaporizers",
      "Concentrate",
      "Edible",
      "Topicals",
      "CBC",
      "Seeds"
    ];

    String FINAL_URL_REQUEST_LIST = "";
    String tempStoreUrlRequest = "";
    String tempCollectionUrlRequest = "";

    for (String storeId in uniqueStoreIDs) {
      // générer le URL pour le store spécifique
      tempStoreUrlRequest =
          "https://dutchie.com/graphql?operationName=ConsumerDispensaries&variables=%7B%22dispensaryFilter%22%3A%7B%22cNameOrID%22%3A%22$storeId%22%7D%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%2226b5c68867077141fb0d4f9a341008d1d306cdb1b4bb67bf81d4bb8dfeae02d8%22%7D%7D";
      // concaténer le string final
      FINAL_URL_REQUEST_LIST += "\nSTORE:\n" + tempStoreUrlRequest + "\n\nCollections:\n";
      for (String col in collections) {
        // générer le URL pour chaque collections du store spécifique
        tempCollectionUrlRequest = "https://dutchie.com/graphql?operationName=FilteredProducts&variables=%7B%22includeCannabinoids%22%3Afalse%2C%22showAllSpecialProducts%22%3Atrue%2C%22productsFilter%22%3A%7B%22dispensaryId%22%3A%22$storeId%22%2C%22pricingType%22%3A%22rec%22%2C%22strainTypes%22%3A%5B%5D%2C%22subcategories%22%3A%5B%5D%2C%22Status%22%3A%22Active%22%2C%22removeProductsBelowOptionThresholds%22%3Atrue%2C%22types%22%3A%5B%22$col%22%5D%2C%22useCache%22%3Afalse%2C%22sortDirection%22%3A-1%2C%22sortBy%22%3A%22price%22%2C%22bypassOnlineThresholds%22%3Afalse%2C%22isKioskMenu%22%3Afalse%7D%2C%22page%22%3A0%2C%22perPage%22%3A100%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%221d6f7daf36ba858ae6e63edf15bffd3653eaf2969167b54db1bb05faa0edb0e0%22%7D%7D";
        // concaténer le string final
        FINAL_URL_REQUEST_LIST += tempCollectionUrlRequest + "\n";
      }
    }

    // LOG LE STRING FINAL
    log(FINAL_URL_REQUEST_LIST);

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primary_blue,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Loading...', style: TextStyle(color: primary_blue)),
        ],
      ),
    );
  }
}
