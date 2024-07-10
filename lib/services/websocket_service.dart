import 'dart:developer';

import 'package:smartattend_app/locator.dart';
import 'package:smartattend_app/services/background_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static const wsURL =
      'http://192.168.215.244:3000'; // replace with your pc wifi ipv4(keep the port same)
  static IO.Socket socket = IO.io(SocketService.wsURL,
      IO.OptionBuilder().setTransports(['websocket']).build());

  static void sendMessage(String message) {
    socket.emit('client', message);
  }
}
