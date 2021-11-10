import 'package:socket_io_client/socket_io_client.dart' as io;

class NewMessageScreenArgument {
  io.Socket socket;

  NewMessageScreenArgument(this.socket);
}