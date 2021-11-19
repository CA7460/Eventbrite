import 'package:event_app/modules/app_features/main_wall/models/comment_model.dart';
import 'package:event_app/modules/app_features/main_wall/models/post_model.dart';
import 'package:event_app/modules/app_features/main_wall/repositories/test_post_comment.dart';
import 'package:event_app/utils/utils.dart';
import 'package:event_app/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:event_app/config/theme/colors.dart';

class PostListItem extends StatelessWidget {
  final PostModel event;

  const PostListItem(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        //margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
        color: textbox_background,
        borderOnForeground: true,
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              Utils.mainWallNav.currentState!
                  .pushNamed(commentWallRoute, arguments: event);
              // Utils.mainAppNav.currentState!
              //     .pushNamed(carPoolListRoute, arguments: events[index]);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.message, //nom event
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    Text(getnumcomment(event.postid),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                  ]),
            )));
  }
}

String getnumcomment(String postid) {
  List<CommentModel> list = getComments(postid);
  switch (list.length) {
    case 0:
      return "0 commentaire";
    case 1:
      return "1 commentaire";
    default:
      return list.length.toString() + " commentaires";
  }
}

List<CommentModel> getComments(String postid) {
  //demande des posts lier au eventid dans database
  var reponse =
      commentslistes.map((event) => CommentModel.fromJson(event)).toList();
  return reponse.where((element) => element.postid.startsWith(postid)).toList();
}
