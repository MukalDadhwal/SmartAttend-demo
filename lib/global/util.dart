import 'package:camera/camera.dart';

typedef CallBackFunction = void Function(String courseName);

typedef CameraCallBackFunction = void Function(CameraDescription description);

typedef AnimateToPageCallBackFunction = Future<void> Function(
    int pageIndex, Duration duration);
