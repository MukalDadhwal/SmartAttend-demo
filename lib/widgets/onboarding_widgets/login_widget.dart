import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/widgets/button_widget.dart';
import 'package:smartattend_app/widgets/logo_widget.dart';
import 'package:smartattend_app/widgets/textfield_widget.dart';

class LoginWidget extends StatefulWidget {
  final PageController pageController;
  const LoginWidget({super.key, required this.pageController});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late TextEditingController idController;
  late TextEditingController passwordController;
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    idController = TextEditingController();
    passwordController = TextEditingController();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation1 = Tween<Offset>(
      begin: Offset(0.0, 4.sp), // Start from left outside the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

    _animation2 = Tween<Offset>(
      begin: Offset(0.0, 2.5.sp), // Start from bottom outside the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller1.forward();
    _controller2.forward();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: _animation1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const LogoWidget(),
              Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Text(
                  "SmartAttend",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
        SlideTransition(
          position: _animation2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.sp, 35.sp, 20.sp, 20.sp),
                child: TextFieldWidget(
                  controller: idController,
                  hintText: 'Your ID',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                child: TextFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.sp, right: 20.sp, top: 20.sp, bottom: 20.sp),
                child: ButtonWidget(
                    onPressed: () => widget.pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        ),
                    text: 'Log in'),
              ),
              InkWell(
                child: Text(
                  'Forgot Password',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 20.sp),
                child: SizedBox(
                  height: 15.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(1.0),
                      backgroundColor: const MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Create new account',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
