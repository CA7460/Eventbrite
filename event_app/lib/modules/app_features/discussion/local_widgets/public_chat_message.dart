import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class PublicChatMessage extends StatelessWidget {
  final String senderName;
  final String content;
  final bool isSender;
  final bool isSeen;
  final bool isExpanded;
  final String sentAt;

  const PublicChatMessage({
    Key? key, 
    required this.senderName, 
    required this.content, 
    required this.isSender, 
    required this.sentAt, 
    required this.isSeen,
    required this.isExpanded
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,8,24,8),
      child: Column(
        children: [
          if (isExpanded) ...[
          Padding(
            padding: EdgeInsets.only(
              bottom: isSender? 8.0: 0),
            child: Text(
              sentAt,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey
              ),
            ),
          ),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: isSender? MainAxisAlignment.end: MainAxisAlignment.start,
            children: [ if (!isSender) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(8,8,8,2),
                child: CircleAvatar(
                  radius: 16,
                  child: Text(senderName.substring(0,1).toUpperCase()),
                ),
              ),],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [ 
                  if (!isSender) ...[
                  Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Text(
                      senderName,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey
                      ),
                    ),
                  ),],
                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                     color: !isSender? primary_blue: Colors.grey.shade800
                    ),
                    child: Text(
                      content,
                      style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white
                      )
                    )
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}