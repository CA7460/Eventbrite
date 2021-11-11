import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/models/attendee_list.dart';
import 'package:event_app/models/current_event.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:event_app/modules/app_features/discussion/models/conversation_type.dart';
import 'package:event_app/modules/app_features/discussion/models/message.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
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
  final List<User> sendTo = [];
  late TextEditingController _contentTextController;
  late TextEditingController _titleTextController;
  late AttendeeList attendees;
  late List<User> sendees;
  late User selectedSendee;
  int togglePosition = 0;

  bool _validateForm() {
    return _messageFormKey.currentState!.validate();
  }

  List<String> _getAttendeeNames(List<User> attendees) {
    List<String> names = [];
    for (var attendee in attendees) {
      names.add(attendee.prenom + ' ' + attendee.nom);
    }
    return names;
  }

  Conversation _makeConversation(title, members, type) {
    Conversation conversation =Conversation.fromNewMessage(title, members, type, DateTime.now());
    return conversation;
  }

  _send(){
    //Send a message
    //take receivers as argument, checks if group exists
      //sends message to right conversation if it does
    //else
      //Creates a new conversation if it doesnt
        //Sends message to new conversation
  }

  @override
  void initState() {
    LoggedUser loggedUser = Provider.of<LoggedUser>(context, listen:false);
    attendees = Provider.of<AttendeeList>(context, listen:false);
    sendees = attendees.attendees.where((attendee) {
      return attendee.userid != loggedUser.user!.userid;
    }).toList();
    selectedSendee = sendees[0];
    _contentTextController = TextEditingController();
    _titleTextController = TextEditingController();
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:40, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text('Title'),
                      //hintText: 'Title'
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(40)],
                    controller: _titleTextController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text('Message'),
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
                  Text('Send to:'),
                  DropdownButton(
                    value: selectedSendee,
                    onChanged: (value) {
                      setState(() {
                        selectedSendee = value as User;
                      });
                    },
                    items: sendees.map((sendee){
                      return DropdownMenuItem(
                        child: Text(sendee.prenom + ' '+ sendee.nom),
                        value: sendee
                      );
                    }).toList(),
                    hint: Text('Send to:'),
                  ),
                  ],
                  SizedBox(height: 70),
                  PrimaryButton(
                    'Send',
                    eventbrite_red,
                    onPressed: () async {
                        if (_validateForm()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _send();
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