import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallText extends StatelessWidget {
  final String title;
  const SmallText({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20.w,top: 60.h,bottom: 12.h),
        child: Text(title,style: TextStyle(color: Colors.black,fontSize: 22.sp,fontFamily: "satoshi"),));
  }
}
