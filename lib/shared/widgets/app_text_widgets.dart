import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Text22 extends StatelessWidget {
  final String title;
  const Text22({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 22.sp, fontFamily: "satoshi"),
    );
  }
}

class Text14 extends StatelessWidget {
  final String title;
  const Text14({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 17.sp, fontFamily: 'satoshi', fontWeight: FontWeight.w900),
    );
  }
}
