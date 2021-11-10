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
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
  late Map<String, dynamic> formData;
  late AttendeeList attendees;


  //Send a message
    //take receivers as argument, checks if group exists
      //sends message to right conversation if it does
    //else
      //Creates a new conversation if it doesnt
        //Sends message to new conversation

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
    
  }

  @override
  void initState() {
    attendees = Provider.of<AttendeeList>(context, listen:false);
    formData = {
      'Name': attendees.attendees[0].prenom + ' ' + attendees.attendees[0].nom
    };
    _contentTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentEvent currentEvent = Provider.of<CurrentEvent>(context);
    final LoggedUser loggedUser = Provider.of<LoggedUser>(context);
    final List<String> attendeeNames = _getAttendeeNames(attendees.attendees);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _contentTextController,
                ),
                TextFormField(

                ),
                SizedBox(height: 30),
                PrimaryButton(
                  'Send',
                  eventbrite_red,
                  onPressed: () async {
                      if (_validateForm()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        //Conversation conversation = _makeConversation(currentEvent.event.eventid, );
                        
                      }
                    }
                )
              ],
            ),
          ),
          key: _messageFormKey
,
        )
      )
    );
  }
}