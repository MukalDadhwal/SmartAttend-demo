import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/widgets/alertdialog_widget.dart';
import 'package:smartattend_app/widgets/lucify_text.dart';
import 'package:smartattend_app/widgets/onboarding_widgets/attendence_history.dart';
import 'package:smartattend_app/widgets/onboarding_widgets/capture_screen.dart';
import 'package:smartattend_app/widgets/onboarding_widgets/course_list.dart';
import 'package:smartattend_app/widgets/onboarding_widgets/enter_code.dart';
import 'package:smartattend_app/widgets/onboarding_widgets/login_widget.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with WidgetsBindingObserver {
  late final PageController pageController;
  String? courseName;
  CameraDescription? cameraDescription;

  void selectCourseName(String course) {
    setState(() => courseName = course);
  }

  void selectCamera(CameraDescription cameraDescription) {
    setState(() => this.cameraDescription = cameraDescription);
  }

  Future<void> animateToNextPage(int page, Duration duration) async {
    await pageController.animateToPage(
      page,
      duration: duration,
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _showWarningNotification(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "hello",
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeOut.transform(a1.value);
        return Transform(
          transform:
              Matrix4.translationValues(0.0, 200 * (1 - curvedValue), 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDiaglogWidget(
          imagePath: 'lib/global/assets/alert_warning.png',
          title: 'Your attendance has been Flagged!',
          buttonText: 'Done',
          content: "Your app moved in background during the process”",
          callback: Navigator.of(context).pop,
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        log("Inactive");
        break;
      case AppLifecycleState.paused:
        _showWarningNotification(
            context); // showing a alert box whenever app is the background
        break;
      case AppLifecycleState.resumed:
        log("Resumed");
        break;
      case AppLifecycleState.detached:
        log("Suspending");
        break;
      case AppLifecycleState.hidden:
        log("Hidden");
        break;
      default:
        log('unknow state');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90.h,
                child: PageView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {},
                  children: [
                    LoginWidget(pageController: pageController),
                    CourseListWidget(
                      pageController: pageController,
                      callback: selectCourseName,
                    ),
                    AttendenceList(
                      callback: animateToNextPage,
                      courseName: courseName,
                      callBack: selectCamera,
                    ),
                    CaptureScreenWidget(
                      camera: cameraDescription,
                      callback: animateToNextPage,
                    ),
                    EnterCodeWidget(callback: animateToNextPage),
                  ],
                ),
              ),
              const LucifyText(),
            ],
          ),
        ),
      ),
    );
  }
}
