import 'package:event_app/modules/app_features/discussion/local_widgets/avatar_title.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_list.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:flutter/material.dart';

class MainMessengerScreen extends StatefulWidget {
  const MainMessengerScreen({
    Key? key,
  }) : super(key: key);


  @override
  State<MainMessengerScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MainMessengerScreen> {

  final List<Tab> tabs = const <Tab>[
    Tab(text: 'Inbox'),
    Tab(text: 'Chatrooms'),
    Tab(text: 'Carpool'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: tabs),
          title: const AvatarTitle(avatarLetter: 'I', title: 'Chats',),
        ),
        body: const TabBarView(children: [
          ChatList(conversationType: ConversationType.private),
          ChatList(conversationType: ConversationType.public),
          ChatList(conversationType: ConversationType.carpool)
        ], )
      ),
    );
  }
}

