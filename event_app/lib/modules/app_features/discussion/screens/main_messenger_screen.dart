import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/conversation_type.dart';
import 'package:flutter_application_1/widgets/avatar_title.dart';
import 'package:flutter_application_1/widgets/chat_list.dart';
import 'package:provider/provider.dart';


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

