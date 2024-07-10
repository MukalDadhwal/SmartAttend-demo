import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get_it/get_it.dart';
import 'package:smartattend_app/services/background_service.dart';

final sl = GetIt.I;

void setup() {
  // registering the websocket and background service
  sl.registerSingleton(BackgroundService(FlutterBackgroundService()));
}
