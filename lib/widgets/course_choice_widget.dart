import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/util.dart';

class CourseChoiceWidget extends StatefulWidget {
  final String courseName;
  final CallBackFunction callBack;

  const CourseChoiceWidget({
    super.key,
    required this.courseName,
    required this.callBack,
  });

  @override
  State<CourseChoiceWidget> createState() => _CourseChoiceWidgetState();
}

class _CourseChoiceWidgetState extends State<CourseChoiceWidget> {
  bool _isChosen = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChosen = !_isChosen;
        });
        widget.callBack(widget.courseName);
      },
      child: Container(
        width: 100.w,
        height: 6.h,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _isChosen ? const Color(0xffCDFFCC) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xff979797), width: 1.0),
        ),
        child: Row(
          children: [
            Text(
              widget.courseName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 10),
            _isChosen
                ? Image.asset(
                    "lib/global/assets/checkbox.png",
                    fit: BoxFit.cover,
                    width: 18.sp,
                    height: 18.sp,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
