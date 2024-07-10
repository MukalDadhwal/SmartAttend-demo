import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class BackgroundService {
  final FlutterBackgroundService _service;
  static AwesomeNotifications notifications = AwesomeNotifications();

  BackgroundService(this._service);

  void startBackgroundService() {
    _service.startService();
  }

  void stopBackgroundService() {
    _service.invoke("stop");
  }

  Future<void> initializeService() async {
    await notifications.initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xffe43e3a),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          onlyAlertOnce: false,
          channelShowBadge: true,
          criticalAlerts: true,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Basic group',
        )
      ],
      debug: true,
    );
    await _service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onStart,
        isForegroundMode: false,
        autoStartOnBoot: false,
      ),
    );
  }

  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    return true;
  }

  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    await notifications.createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'high_importance_channel',
        actionType: ActionType.Default,
        title: 'Hello World!',
        body: 'This is my first notification!',
        displayOnForeground: true,
        fullScreenIntent: true,
        criticalAlert: true,
        displayOnBackground: false,
      ),
    );
    service.on("stop").listen((event) {
      service.stopSelf();
      log('service stopped');
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      print("service is successfully running ${DateTime.now().second}");
    });
  }
}
