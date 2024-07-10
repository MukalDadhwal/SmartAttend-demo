import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/locator.dart';
import 'package:smartattend_app/pages/splash_page.dart';
import 'package:smartattend_app/services/background_service.dart';
import 'package:smartattend_app/global/theme.dart' show GlobalThemData;
import 'package:smartattend_app/pages/onboarding_page.dart';
import 'package:smartattend_app/services/notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup(); // setting up service locators
  await sl<BackgroundService>().initializeService();
  setListenerAndAskPermission();
  runApp(const ProviderScope(child: MainApp()));
}

Future<void> setListenerAndAskPermission() async {
  await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod);

  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder:
          (BuildContext context, Orientation orientation, ScreenType type) {
        return MaterialApp(
            title: "SmartAttend App",
            theme: GlobalThemData.themeData(
              context,
              GlobalThemData.lightColorScheme,
              GlobalThemData.lightFocusColor,
            ),
            themeMode: ThemeMode.light,
            home: const SplashScreen(),
            // initialRoute: '/onboard',
            routes: {
              '/onboard': (context) => const OnBoardingPage(),
            });
      },
    );
  }
}
