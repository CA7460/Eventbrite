import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/main_wall/local_widgets/comment_list_item.dart';
import 'package:event_app/modules/app_features/main_wall/models/comment_model.dart';
import 'package:event_app/modules/app_features/main_wall/models/post_model.dart';
import 'package:event_app/modules/app_features/main_wall/repositories/test_post_comment.dart';
import 'package:flutter/material.dart';

Future<List<CommentModel>> getComments(String postid) async {
  //demande des posts lier au eventid dans database
  var reponse =
      commentslistes.map((event) => CommentModel.fromJson(event)).toList();
  return reponse.where((element) => element.postid.startsWith(postid)).toList();
}

class CommentWallScreen extends StatefulWidget {
  final PostModel post;
  const CommentWallScreen({Key? key, required this.post}) : super(key: key);
  @override
  _CommentWallState createState() => _CommentWallState();
}

class _CommentWallState extends State<CommentWallScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final topLayoutHeight = screenSize.height * 0.1;
    final centerLayoutHeight = screenSize.height * 0.80;
    return Center(
        child: Column(
      children: [
        SafeArea(
            child: Card(
                //margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
                color: eventbrite_red,
                borderOnForeground: true,
                child: InkWell(
                    splashColor: Colors.red.withAlpha(30),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.post.message, //nom event
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ]),
                    )))),
        Container(
          alignment: Alignment.topCenter,
          height: centerLayoutHeight,
          color: primary_background,
          child: FutureBuilder<List<CommentModel>>(
              future: getComments(widget.post.postid),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<CommentModel>> snapshot,
              ) {
                if (snapshot.hasData) {
                  List<CommentModel> events = snapshot.data!;
                  return CommentsListViewWidget(widget.post, events, this);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ],
    ));
  }
}

class CommentsListViewWidget extends StatelessWidget {
  final PostModel post;
  final List<CommentModel> events;
  final dynamic _listViewStateInstance;

  const CommentsListViewWidget(
      this.post, this.events, this._listViewStateInstance,
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
                return CommentListItem(events, index);
              }),
    );
  }

  Widget emptyList() {
    return Center(
        child: Text(
      'No Comment availble',
      style: TextStyle(
        color: Colors.white,
      ),
    ));
  }
}
