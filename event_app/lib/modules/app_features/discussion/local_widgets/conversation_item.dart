import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {

  final String title;
  final String? lastMessage;
  final String updatedAt;

  const ConversationItem({
    Key? key,
    required this.title,
    this.lastMessage,
    required this.updatedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,12,8,4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8,0,12,0),
            child: CircleAvatar(
              backgroundColor: primary_blue,
              radius: 16,
              child: Text(title == ''? '': title.substring(0, 1)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 3,),
                Text(
                  lastMessage == null? '': lastMessage!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Text(
              updatedAt,
              style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                  ),),
          )
        ],
      ),
    );
  }
}