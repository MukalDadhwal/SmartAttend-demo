import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TableCellWidget extends StatelessWidget {
  final String text;
  final double? height;
  final bool? isHeader;
  const TableCellWidget({super.key, required this.text, this.height, this.isHeader});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 4.h,
      child: Center(
        child: Text(
          text,
          style: (isHeader != null)
              ? TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                )
              : null,
        ),
      ),
    );
  }
}
