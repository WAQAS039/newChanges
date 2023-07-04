import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../../../../../shared/widgets/brand_button.dart';
import '../../../../settings/pages/app_colors/app_colors_provider.dart';
import '../provider/tasbeeh_provider.dart';

Future<void> showCounterDialog(BuildContext context, TasbeehProvider tasbeehValue, AppColorsProvider appColors) async {
  await showDialog(context: context, builder: (context) {
    var text = TextEditingController();
    return Consumer<TasbeehProvider>(
      builder: (context, value, child) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text(localeText(context, "enter_tasbeeh_count"),textAlign: TextAlign.center,style: TextStyle(
              fontFamily: 'satoshi',
              fontSize: 16.sp)),
          content: Container(
            margin:EdgeInsets.only(left: 20.w,right: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.h,top: 25.h),
                  child: Text(localeText(context, "enter_the_count"),style: TextStyle(
                      fontSize: 10.sp
                  ),),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 46.h,
                      padding: EdgeInsets.only(left: 10.w),
                      margin:EdgeInsets.only(bottom: 5.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.grey5)
                      ),
                      child: TextField(
                        controller: text,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(right: 10.w,left: 10.w),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                        ),
                      ),
                    ),
                    value.error ? Container(
                        margin: EdgeInsets.only(bottom: 10.w),
                        width: double.maxFinite,
                        child: Text("error",textAlign: TextAlign.left,style: TextStyle(
                            color: Colors.red,
                            fontSize: 10.sp,
                            fontFamily: "satoshi"
                        ),)) : Container(margin: EdgeInsets.only(bottom: 5.h),)
                  ],
                ),
                BrandButton(text: localeText(context, "confirm"), onTap: (){
                  if(text.text.contains(".") || text.text == "0" || text.text.isEmpty){
                    tasbeehValue.setError(true);
                  }else{
                    tasbeehValue.setCustomCounter(int.parse(text.text),context,appColors);
                    Navigator.of(context).pop();
                    tasbeehValue.setError(false);
                  }
                }),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        );
      },
    );
  },);
}