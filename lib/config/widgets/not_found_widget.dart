import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Text(
          textAlign: TextAlign.center,
          'Does not exist😣',
          style: TextStyle(
            color: Colors.purpleAccent,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
