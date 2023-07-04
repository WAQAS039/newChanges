import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextStyle? style; // Add the 'style' parameter

  const TitleText(
      {Key? key, required this.title, this.fontSize = 0, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style != null
          ? style
          : TextStyle(
              fontSize: fontSize == 0 ? 22.1.sp : fontSize,
              fontFamily: "satoshi"),
    );
  }
}
