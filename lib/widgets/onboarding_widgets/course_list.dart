import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/util.dart';
import 'package:smartattend_app/widgets/button_widget.dart';
import 'package:smartattend_app/widgets/course_choice_widget.dart';
import 'package:smartattend_app/widgets/profile_widget.dart';

class CourseListWidget extends StatefulWidget {
  final PageController pageController;
  final CallBackFunction callback;
  const CourseListWidget(
      {super.key, required this.callback, required this.pageController});

  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;

  void animateToNextPage(String courseName) {
    switch (courseName) {
      case 'MTL 100':
        widget.callback('MTL 100');
        break;
      case 'PYL 100':
        widget.callback('PYL 100');
        break;
      case 'CML 100':
        widget.callback('CML 100');
        break;
      case 'APL 105':
        widget.callback('APL 105');
        break;
      case 'NEN 100':
        widget.callback('NEN 100');
        break;

      default:
        widget.callback('MTL 100');
    }

    widget.pageController.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation1 = Tween<Offset>(
      begin: Offset(4.sp, 0.0), // Start from left outside the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _animation2 = Tween<Offset>(
      begin: Offset(0.0, 5.sp), // Start from bottom outside the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 30.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileWidget(
            pageIndex: 1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 9.h, bottom: 3.h),
            child: Text(
              'Courses List',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SlideTransition(
            position: _animation1,
            child: Column(
              children: [
                CourseChoiceWidget(
                    courseName: 'MTL 100', callBack: animateToNextPage),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  child: CourseChoiceWidget(
                      courseName: 'PYL 100', callBack: animateToNextPage),
                ),
                CourseChoiceWidget(
                    courseName: 'CML 100', callBack: animateToNextPage),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  child: CourseChoiceWidget(
                      courseName: 'APL 105', callBack: animateToNextPage),
                ),
                CourseChoiceWidget(
                    courseName: 'NEN 100', callBack: animateToNextPage),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 11.h),
            child: SlideTransition(
              position: _animation2,
              child: Hero(
                  tag: 'slide',
                  child:
                      ButtonWidget(onPressed: () {}, text: 'Mark Attendance')),
            ),
          )
        ],
      ),
    );
  }
}
