import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/util.dart';
import 'package:smartattend_app/widgets/button_widget.dart';
import 'package:smartattend_app/widgets/dropdown_button.dart';
import 'package:smartattend_app/widgets/profile_widget.dart';
import 'package:smartattend_app/widgets/table_cell.dart';

class AttendenceList extends StatefulWidget {
  final AnimateToPageCallBackFunction callback;
  final String? courseName;
  final CameraCallBackFunction callBack;

  const AttendenceList(
      {super.key,
      required this.courseName,
      required this.callback,
      required this.callBack});

  @override
  State<AttendenceList> createState() => _AttendenceListState();
}

class _AttendenceListState extends State<AttendenceList>
    with SingleTickerProviderStateMixin {
  TextStyle myLabelTextStyle = const TextStyle(color: Colors.black);
  String? dropdownValue;
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 10.sp), // Start from bottom outside the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 30.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileWidget(
            callback: widget.callback,
            pageIndex: 2,
            implementBack: true,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.h, bottom: 1.5.h),
            child: Text(
              widget.courseName!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'lib/global/assets/location.png',
                height: 20.sp,
                width: 20.sp,
              ),
              const SizedBox(width: 5),
              const Text('LH 121'),
              const SizedBox(width: 15),
              Image.asset(
                'lib/global/assets/clock.png',
                height: 20.sp,
                width: 20.sp,
              ),
              const SizedBox(width: 5),
              const Text('11:00 AM'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
            child: SlideTransition(
              position: _animation,
              child: Hero(
                tag: 'slide',
                child: ButtonWidget(
                  onPressed: () async {
                    final cameras = await availableCameras();
                    final firstCamera = cameras[1];

                    widget.callBack(firstCamera);

                    await widget.callback(
                      3,
                      const Duration(milliseconds: 500),
                    );
                  },
                  text: 'Mark Attendance',
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attendance history\nand statistics',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: const Color(0xff1B1B1B),
                ),
              ),
              const DropdownButtonWidget()
            ],
          ),
          _buildTableView(),
        ],
      ),
    );
  }

  Widget _buildTableView() {
    return Padding(
      padding: EdgeInsets.only(top: 20.sp),
      child: Table(
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xffE1E1E1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            children: [
              TableCellWidget(
                text: 'Date',
                height: 6.h,
                isHeader: true,
              ),
              TableCellWidget(
                text: 'Day',
                height: 6.h,
                isHeader: true,
              ),
              TableCellWidget(
                text: 'Attendance',
                height: 6.h,
                isHeader: true,
              ),
            ],
          ),
          const TableRow(children: [
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0)
          ]),
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xffCDFFCC),
              borderRadius: BorderRadius.circular(4.0),
            ),
            children: const [
              TableCellWidget(text: '12 June 2024'),
              TableCellWidget(text: 'Monday'),
              TableCellWidget(text: 'Present'),
            ],
          ),
          const TableRow(children: [
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0)
          ]),
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xffCDFFCC),
              borderRadius: BorderRadius.circular(4.0),
            ),
            children: const [
              TableCellWidget(text: '14 June 2024'),
              TableCellWidget(text: 'Wednesday'),
              TableCellWidget(text: 'Present'),
            ],
          ),
          const TableRow(children: [
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0)
          ]),
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xffFFE3E3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            children: const [
              TableCellWidget(text: '15 June 2024'),
              TableCellWidget(text: 'Thursday'),
              TableCellWidget(text: 'Absent'),
            ],
          ),
          const TableRow(children: [
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0)
          ]),
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xffCDFFCC),
              borderRadius: BorderRadius.circular(4.0),
            ),
            children: const [
              TableCellWidget(text: '16 June 2024'),
              TableCellWidget(text: 'Friday'),
              TableCellWidget(text: 'Present'),
            ],
          ),
          const TableRow(children: [
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0)
          ]),
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xffCDFFCC),
              borderRadius: BorderRadius.circular(4.0),
            ),
            children: const [
              TableCellWidget(text: '17 June 2024'),
              TableCellWidget(text: 'Saturday'),
              TableCellWidget(text: 'Present'),
            ],
          ),
        ],
      ),
    );
  }
}
