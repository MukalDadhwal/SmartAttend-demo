import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/widgets/button_widget.dart';

class AlertDiaglogWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? content;
  final String buttonText;
  final VoidCallback callback;

  const AlertDiaglogWidget({
    super.key,
    this.content,
    required this.imagePath,
    required this.title,
    required this.buttonText,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetAnimationCurve: Curves.easeOut,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.all(18.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff1B1B1B),
                  ),
                ),
                content != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                        child: Text(
                          content!,
                          style: TextStyle(
                            color: const Color(0xff1B1B1B),
                            fontSize: 15.sp,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.sp, right: 28.sp),
              child: ButtonWidget(
                onPressed: callback,
                text: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
