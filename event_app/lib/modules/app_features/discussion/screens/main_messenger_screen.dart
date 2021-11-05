import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/avatar_title.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_list.dart';
import 'package:event_app/modules/app_features/discussion/models/chat_screen_argument.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:event_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class MainMessengerScreen extends StatefulWidget {
  const MainMessengerScreen({
    Key? key,
  }) : super(key: key);


  @override
  State<MainMessengerScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MainMessengerScreen> {
  late io.Socket socket;
  final List<Tab> tabs = const <Tab>[
    Tab(text: 'Inbox'),
    Tab(text: 'Chatrooms'),
    Tab(text: 'Carpool'),
  ];

  @override
  void initState() {
    _initSocket();
    super.initState();
  }

  _initSocket() {
    try {
      socket = io.io('http://192.168.1.159:5000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      // socket = io.io('https://eventbrite-realtime.herokuapp.com/', <String, dynamic>{
      //   'transports': ['websocket'],
      //   'autoConnect': false,
      // });
      socket.connect();
      socket.onConnect((data) => print('Connected'));
      socket.onDisconnect((data) => print('Disconnected'));
      // socket.on('message', (data) => _addToMessageList(data));
    }catch (e) {
      print(e.toString());
    }
  }

  // _addToMessageList(data) {
  //   Message message = Message.fromJson(data);
  //   MessageList messages = Provider.of<MessageList>(context, listen: false);
  //   messages.addMessage(message);
  // }

  _goToChatScreen(convoid) {
    Utils.appFeaturesNav.currentState!.pushNamed(
      chatScreenRoute,
      arguments: ChatScreenArgument(
        'January Report',
         socket,
      )
    );
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
        body:  TabBarView(children: [
          ChatList(conversationType: ConversationType.private, onTap: _goToChatScreen,),
          ChatList(conversationType: ConversationType.public, onTap:_goToChatScreen,),
          ChatList(conversationType: ConversationType.carpool, onTap: _goToChatScreen,)
        ], )
      ),
    );
  }
}

