import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartattend_app/global/util.dart';

class ProfileWidget extends StatelessWidget {
  final bool implementBack;
  final AnimateToPageCallBackFunction? callback;
  final int pageIndex;
  const ProfileWidget({
    super.key,
    this.implementBack = false,
    this.callback,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !implementBack
            ? Text(
                'SmartAttend',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI',
                  letterSpacing: 1.0,
                ),
              )
            : BackButton(
                onPressed: () =>
                    callback!(pageIndex - 1, const Duration(milliseconds: 500)),
                color: const Color(0xff7B7B7B),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color(0xffDADADA),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
        CircleAvatar(
          radius: 20.sp,
          backgroundImage: const AssetImage('lib/global/assets/profile.png'),
        ),
      ],
    );
  }
}
