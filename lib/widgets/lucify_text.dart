import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LucifyText extends StatelessWidget {
  const LucifyText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Text(
        "Powered by Lucify",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
