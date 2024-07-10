import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7.h),
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('lib/global/assets/logo.png'),
        ), //NetworkImage

        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            offset: const Offset(
              -2.0,
              2.0,
            ),
            blurRadius: 15.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          const BoxShadow(
            color: Colors.white,
            offset: Offset(2.0, -2.0),
            blurRadius: 0.0,
            spreadRadius: 6.0,
          ), //BoxShadow
        ],
      ),
    );
  }
}
