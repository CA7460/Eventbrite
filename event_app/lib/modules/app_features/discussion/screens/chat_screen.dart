import 'dart:developer';

import 'package:event_app/models/logged_user.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/avatar_title.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_input.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_window.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;
  final io.Socket socket;
  const ChatScreen({
    Key? key,
    required this.socket,
    required this.conversation
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _textController;
  late ScrollController _scrollController;
  

  @override
  void initState() {
    _setSocket();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((_){
      _scrollToBottom();
    });
    super.initState();
  }

  _send(LoggedUser loggedUser, String convoId){
    var message = Message.noId(loggedUser.user!, _textController.text, DateTime.now(), false);
    if(message.content != '') {
      Map<String, dynamic> payload ={
        "message": message.toJson(),
        "convoId": convoId
      };
      widget.socket.emit('message', payload);
      setState(() {
        _textController.text = '';
      });
    }
  }

  _setSocket(){
    widget.socket.on('message', (data) => _addToMessageList(data['message']));
  }

  _addToMessageList(data) { // Need to get messageId and User for sentBy
    final User sentBy = widget.conversation.members.firstWhere((user) => user.userid == data['sentBy']);
    Message message = Message(data['messageId'], sentBy, data['content'], DateTime.parse(data['sentAt']), data['isSeen'] == 0? false: true);
    MessageList messages = Provider.of<MessageList>(context, listen: false);
    messages.addMessage(message);
  }

   _scrollToBottom() {
    if(_scrollController.hasClients){
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent
        );
      }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoggedUser loggedUser = Provider.of<LoggedUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: AvatarTitle(title: widget.conversation.title!, avatarLetter: widget.conversation.title!.substring(0, 1)), //should get conversation from parent
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ChatWindow(
                controller: _scrollController,
                convoId: widget.conversation.convoId!,
              )
            ),
            ChatInput(
              controller: _textController,
              onSubmit: () => _send(loggedUser, widget.conversation.convoId!))
          ],
        )
      ),
    );
  }
}