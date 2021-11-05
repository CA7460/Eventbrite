import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatScreenArgument {
  io.Socket socket;
  String convoId;

  ChatScreenArgument(this.convoId, this.socket);
}