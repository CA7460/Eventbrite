import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/models/current_event.dart';
import 'package:event_app/modules/app_features/main_wall/local_widgets/post_list_item.dart';
import 'package:event_app/modules/app_features/main_wall/models/post_model.dart';
import 'package:event_app/modules/app_features/main_wall/repositories/test_post_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<List<PostModel>> getPosts(String eventid) async {
  //demande des posts lier au eventid dans database
  var reponse = postslistes.map((event) => PostModel.fromJson(event)).toList();
  return reponse
      .where((element) => element.eventid.startsWith(eventid))
      .toList();
}

class MainWallScreen extends StatefulWidget {
  const MainWallScreen({Key? key}) : super(key: key);
  @override
  _MainWallState createState() => _MainWallState();
}

class _MainWallState extends State<MainWallScreen> {
  @override
  Widget build(BuildContext context) {
    final CurrentEvent currentEvent = Provider.of<CurrentEvent>(context);
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.85;
    return SafeArea(
        child: Center(
            child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text("Mur de " + currentEvent.event!.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: centerLayoutHeight,
          color: primary_background,
          child: FutureBuilder<List<PostModel>>(
              future: getPosts(currentEvent.event!.eventid),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<PostModel>> snapshot,
              ) {
                if (snapshot.hasData) {
                  List<PostModel> events = snapshot.data!;
                  return PostsListViewWidget(events, this);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ],
    )));
  }
}

class PostsListViewWidget extends StatelessWidget {
  final List<PostModel> events;
  final dynamic _listViewStateInstance;

  const PostsListViewWidget(this.events, this._listViewStateInstance,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: events.isEmpty
          ? emptyList()
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return PostListItem(events[index]);
              }),
    );
  }

  Widget emptyList() {
    return Text(
      'No Post availble',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
