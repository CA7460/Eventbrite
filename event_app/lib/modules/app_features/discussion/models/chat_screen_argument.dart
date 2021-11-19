import 'package:event_app/modules/app_features/discussion/models/conversation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatScreenArgument {
  io.Socket socket;
  Conversation conversation;

  ChatScreenArgument(this.conversation, this.socket);
}