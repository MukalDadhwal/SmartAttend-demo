import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/theme.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const TextFieldWidget(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.w,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        cursorHeight: 22.sp,
        style: TextStyle(fontSize: 17.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 17.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.only(
            left: 25.sp,
            top: 25.sp,
            right: 20.sp,
          ),
          fillColor: GlobalThemData.textFieldFillColor,
        ),
      ),
    );
  }
}
