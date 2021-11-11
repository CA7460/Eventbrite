import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/avatar_title.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_list.dart';
import 'package:event_app/modules/app_features/discussion/models/chat_screen_argument.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:event_app/modules/app_features/discussion/models/new_message_screen_argrument.dart';
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
    Utils.messengerNav.currentState!.pushNamed(
      chatScreenRoute,
      arguments: ChatScreenArgument(
        convoid,
         socket,
      )
    );
  }

  _goToNewMessageScreen() {
    Utils.messengerNav.currentState!.pushNamed(
      newMessageRoute,
      arguments: NewMessageScreenArgument(
         socket,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoggedUser loggedUser = Provider.of<LoggedUser>(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: tabs),
          title: AvatarTitle(avatarLetter: loggedUser.user!.prenom.substring(0,1), title: 'Chats',),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _goToNewMessageScreen,
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )
            )
          ],
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

