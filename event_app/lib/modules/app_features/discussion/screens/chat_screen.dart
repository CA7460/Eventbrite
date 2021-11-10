import 'package:event_app/models/logged_user.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/avatar_title.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_input.dart';
import 'package:event_app/modules/app_features/discussion/local_widgets/chat_window.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/modules/app_features/discussion/models/message_list.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String convoId;
  final io.Socket socket;
  const ChatScreen({
    Key? key,
    required this.socket,
    required this.convoId
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

  _send(LoggedUser loggedUser){
    var message = Message.noId(loggedUser.user!, _textController.text, DateTime.now(), false);
    if(message.content != '') {
      widget.socket.emit('message', message.toJson());
      setState(() {
        _textController.text = '';
      });
    }
  }

  _setSocket(){
    widget.socket.on('message', (data) => print(data));
    widget.socket.on('message', (data) => _addToMessageList(data));
  }

  _addToMessageList(data) {
    Message message = Message.fromJson(data);
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
        title: const AvatarTitle(title: 'Dan', avatarLetter: 'D'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ChatWindow(
                controller: _scrollController,
                convoId: widget.convoId,
              )
            ),
            ChatInput(
              controller: _textController,
              onSubmit: () => _send(loggedUser))
          ],
        )
      ),
    );
  }
}