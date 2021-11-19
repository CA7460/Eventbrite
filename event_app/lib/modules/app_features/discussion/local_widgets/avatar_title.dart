import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class AvatarTitle extends StatelessWidget {
  final String avatarLetter;
  final String title;

  const AvatarTitle({
    Key? key, 
    required this.title,
    required this.avatarLetter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        CircleAvatar(
          backgroundColor: primary_blue,
          radius: 16,
          child: Text(
            avatarLetter.substring(0,1)
          ),
        ),
        const SizedBox(width: 16,),
        Text(title),
      ],
    );
  }
}