import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/util.dart';
import 'package:smartattend_app/widgets/alertdialog_widget.dart';
import 'package:smartattend_app/widgets/button_widget.dart';
import 'package:smartattend_app/widgets/profile_widget.dart';
import 'package:smartattend_app/widgets/textfield_widget.dart';

class EnterCodeWidget extends StatefulWidget {
  final AnimateToPageCallBackFunction callback;
  const EnterCodeWidget({super.key, required this.callback});

  @override
  State<EnterCodeWidget> createState() => _EnterCodeWidgetState();
}

class _EnterCodeWidgetState extends State<EnterCodeWidget>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TextEditingController codeController;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  double _bottomPadding = 0;

  @override
  void initState() {
    codeController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 4.sp), // Start from bottom outside the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    setState(() {
      _bottomPadding = bottomInset > 0 ? 50.sp : 0;
    });
  }

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  void _showSuccessDialog(BuildContext context) {
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
          imagePath: 'lib/global/assets/alert_checkbox.png',
          title: 'Your attendance\nwas successfully marked',
          buttonText: 'Done',
          callback: Navigator.of(context).pop,
        );
      },
    );
  }

  void _showFailDialog(BuildContext context) {
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
          title: 'The attendance window for this class\nis not open yet',
          buttonText: 'Done',
          content:
              "If you think this is a mistake,\nplease approach your professor",
          callback: Navigator.of(context).pop,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: _bottomPadding),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Padding(
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileWidget(
              implementBack: true,
              pageIndex: 4,
              callback: widget.callback,
            ),
            Expanded(
              child: SlideTransition(
                position: _animation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Please enter code given by Professor",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.sp, top: 15.sp),
                      child: TextFieldWidget(
                        controller: codeController,
                        hintText: 'Enter Code',
                      ),
                    ),
                    ButtonWidget(
                      onPressed: () async {
                        if (codeController.text.isEmpty) {
                          _showFailDialog(context);
                          // await widget.callback(5, Duration(milliseconds: 500));
                          return;
                        }
                        _showSuccessDialog(context);
                      },
                      text: 'Submit',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
