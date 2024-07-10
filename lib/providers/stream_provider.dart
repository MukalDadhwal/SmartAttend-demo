import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartattend_app/locator.dart';
import 'package:smartattend_app/services/background_service.dart';
import 'package:smartattend_app/services/websocket_service.dart';

final socketProvider = StreamProvider.autoDispose((ref) async* {
  StreamController stream = StreamController();

  SocketService.socket.on('server', (data) {
    if (data == "hello") {
      sl<BackgroundService>().startBackgroundService();
      Future.delayed(const Duration(seconds: 3));
      sl<BackgroundService>().stopBackgroundService();
    }

    stream.add(data);
  });

  SocketService.socket.onerror((_) {
    log("Error IS ${_.toString()}");
  });

  ref.onDispose(() {
    // close socketio
    stream.close();
    SocketService.socket.dispose();
  });

  await for (final value in stream.stream) {
    log('stream value => ${value.toString()}');

    yield value;
  }
});
