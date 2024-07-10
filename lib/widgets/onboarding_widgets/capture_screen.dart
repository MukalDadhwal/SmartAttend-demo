import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/util.dart';
import 'package:smartattend_app/providers/stream_provider.dart';
import 'package:smartattend_app/services/websocket_service.dart';
import 'package:smartattend_app/widgets/button_widget.dart';
import 'package:smartattend_app/widgets/profile_widget.dart';

class CaptureScreenWidget extends ConsumerStatefulWidget {
  final AnimateToPageCallBackFunction callback;
  final CameraDescription? camera;

  const CaptureScreenWidget(
      {super.key, required this.camera, required this.callback});

  @override
  ConsumerState<CaptureScreenWidget> createState() =>
      _CaptureScreenWidgetState();
}

class _CaptureScreenWidgetState extends ConsumerState<CaptureScreenWidget>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  double _progressValue = 0.0;
  double _totalProgress = 1.0;

  @override
  void initState() {
    _updateProgress();
    onNewCameraSelected(widget.camera!);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  void _updateProgress() {
    const oneSec = Duration(milliseconds: 70);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;
        _totalProgress -= 0.1;
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          t.cancel();
          return;
        }
      });
    });
  }

  Future<void> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }
    try {
      XFile file = await cameraController.takePicture();
      File imageFile = File(file.path);

      int currentUnix = DateTime.now().millisecondsSinceEpoch;
      final directory = await getApplicationDocumentsDirectory();
      String fileFormat = imageFile.path.split('.').last;

      await imageFile.copy(
        '${directory.path}/$currentUnix.$fileFormat',
      );
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(socketProvider);
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 30.sp),
      child: Column(
        children: [
          ProfileWidget(
            pageIndex: 3,
            callback: widget.callback,
            implementBack: true,
          ),
          _isCameraInitialized
              ? Padding(
                  padding: EdgeInsets.only(top: 15.sp, bottom: 20.sp),
                  child: SizedBox(
                    height: 55.h,
                    width: 100.h,
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            offset: const Offset(
                              -5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.bottomCenter,
                          children: [
                            AspectRatio(
                              aspectRatio: 1 / controller!.value.aspectRatio,
                              child: controller!.buildPreview(),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25.sp,
                                ),
                                alignment: Alignment.center,
                                height: 6.h,
                                width: double.infinity,
                                color: Colors.black38,
                                child: SizedBox(
                                  height: 12.sp,
                                  child: LinearProgressIndicator(
                                    backgroundColor: const Color(0xffECECEC),
                                    borderRadius: BorderRadius.circular(8.0),
                                    value: _progressValue,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).colorScheme.primary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 60.h,
                  width: 100.h,
                ),
          Text(
            'Timer ${(_totalProgress * 10).round()} Seconds Left',
            style: TextStyle(fontSize: 16.5.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            'Keep your App in Foreground',
            style: TextStyle(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17.sp),
            child: ButtonWidget(
              onPressed: () async {
                SocketService.sendMessage("hey");

                await takePicture();
                await widget.callback(4, const Duration(milliseconds: 500));
              },
              text: 'Capture',
            ),
          ),
        ],
      ),
    );
  }
}
