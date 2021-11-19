import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/modules/app_features/main_wall/models/comment_model.dart';
import 'package:event_app/modules/app_features/main_wall/models/post_model.dart';
import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {
  final List<CommentModel> events;
  final int index;
  const CommentListItem(this.events, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        //margin: EdgeInsets.fromLTRB(48, 6, 42, 0),
        color: eventbrite_red,
        borderOnForeground: true,
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(events[index].message,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(events[index].userid,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ]),
            )));
  }
}
