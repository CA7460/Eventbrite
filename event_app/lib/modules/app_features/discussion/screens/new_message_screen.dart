import 'dart:convert';

import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/models/attendee_list.dart';
import 'package:event_app/models/current_event.dart';
import 'package:event_app/models/eventmod.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/widgets/textfield_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:toggle_switch/toggle_switch.dart';

class NewMessageScreen extends StatefulWidget {
  final io.Socket socket;
  const NewMessageScreen({
    Key? key,
    required this.socket,
  }) : super(key: key);


  @override
  State<NewMessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<NewMessageScreen> {
  final _messageFormKey = GlobalKey<FormState>();
  late ConversationType type;
  late TextEditingController _contentTextController;
  late TextEditingController _titleTextController;

  List<User> sendTo = [];
  late User currentUser;
  late AttendeeList attendees;
  late List<User> sendees;
  late User selectedSendee;
  int togglePosition = 0;

  bool _validateForm() {
    return _messageFormKey.currentState!.validate();
  }

  _setType(){
    switch(togglePosition){
      case 0:
        type = ConversationType.private;
        break;
      case 1:
        type = ConversationType.carpool;
        break;
      case 2:
        type = ConversationType.public;
        break;
    }
  }

  Conversation _makeConversation(title, members, type) {
    Conversation conversation = Conversation.fromNewMessage(title, members, type, DateTime.now());
    return conversation;
  }

  Message _makeMessage(sentBy, content,) {
    Message message = Message.noId(sentBy, content, DateTime.now(), false);
    return message;
  }

  _send(Conversation conversation, Message message, eventId) async {
    final body = {
      "conversation": {
        "convoId": conversation.convoId ?? null,
        "title": conversation.title ?? null,
        "members": conversation.members.map((e) => e.toJson()).toList(),
        // "lastMessage": conversation.lastMessage ?? null,
        "type": type.toString().split('.').last,
        "updatedAt": conversation.updatedAt.toString()
      },
      "message": {
        'messageId': message.messageId,
        'sentBy': message.sentBy.userid,
        'content': message.content,
        'isSeen': message.isSeen == true? 1: 0,
        'sentAt': message.sentAt.toString()
      },
      "eventId": eventId};
    widget.socket.emit('newMessage', body);
  }

  _loadLateFields(){
    LoggedUser loggedUser = Provider.of<LoggedUser>(context, listen:false);
    currentUser = loggedUser.user!;
    attendees = Provider.of<AttendeeList>(context, listen:false);
    sendees = attendees.attendees.where((attendee) {
      return attendee.userid != loggedUser.user!.userid;
    }).toList();
    if(sendees.isEmpty){
      User placeholder = User('0', "Seems like you're", 'alone', 'fake@eventbrite');
      sendees.add(placeholder);

    }
    selectedSendee = sendees[0];
    _contentTextController = TextEditingController();
    _titleTextController = TextEditingController();
  }

  _addNewConvo(convo){

  }

  _setSocket(){
    widget.socket.on('newConvo', (convo) => _addNewConvo(convo));
  }

  @override
  void initState() {
    _setSocket();
    _loadLateFields();
    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentEvent currentEvent = Provider.of<CurrentEvent>(context);
    attendees.loadAttendees(currentEvent.event!.eventid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Send a new Message'),
        backgroundColor: primary_background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Container(
              color: primary_background,
              padding: EdgeInsets.symmetric(horizontal:40, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: primary_green),
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      focusColor: primary_blue,
                      border: UnderlineInputBorder(),
                      label: Text('Title', style: TextStyle(color: primary_blue),),
                      //hintText: 'Title'
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(40)],
                    controller: _titleTextController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    style: TextStyle(color: primary_pink),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide(color: primary_pink)),
                      label: Text('Message', style: TextStyle(color: primary_blue)),
                      //hintText: 'Message'
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(450)],
                    minLines: 5,
                    maxLines: 5,  
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _contentTextController,
                  ),
                  SizedBox(height: 40),
                  ToggleSwitch(
                    inactiveBgColor: Colors.black,
                    borderColor: [primary_blue],
                    borderWidth: 1,
                    inactiveFgColor: primary_green,
                    dividerColor: primary_blue,
                    activeBgColor: [primary_pink],
                    initialLabelIndex: togglePosition,
                    minWidth: 80,
                    totalSwitches: 3,
                    labels: ['Private', 'Carpool', 'Chatroom'],
                    onToggle: (index) {
                      setState(() {
                        togglePosition = index;
                      });
                    },
                  ),
                  SizedBox(height: 60),
                  if (togglePosition != 2) ...[
                  Text('Send to:', style: TextStyle(color: primary_green),),
                  DropdownButton(
                    dropdownColor: Colors.grey.shade900,
                    value: selectedSendee,
                    onChanged: (value) {
                      setState(() {
                        selectedSendee = value as User;
                      });
                    },
                    items: sendees.map((sendee){
                      return DropdownMenuItem(
                        child: Text(sendee.prenom + ' '+ sendee.nom, style: TextStyle(color: primary_pink,)),
                        value: sendee,
                      );
                    }).toList(),
                    hint: Text('Send to:'),
                  ),
                  ],
                  SizedBox(height: togglePosition != 2? 75: 139),
                  PrimaryButton(
                    'Send',
                    eventbrite_red,
                    onPressed: () {
                        if (_validateForm() && sendees[0].userid != '0') {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _setType();
                          if (type != ConversationType.public){
                            sendTo = [];
                            sendTo.add(selectedSendee);
                            sendTo.add(currentUser);
                          } else {
                            sendTo = attendees.attendees;
                          }
                          Conversation newConvo = _makeConversation(_titleTextController.text, sendTo, type);
                          Message newMessage = _makeMessage(currentUser, _contentTextController.text);
                          _send(newConvo, newMessage, currentEvent.event!.eventid);
                        }
                      }
                  )
                ],
              ),
            ),
            key: _messageFormKey
          ),
        )
      )
    );
  }
}