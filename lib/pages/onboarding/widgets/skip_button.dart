import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<ThemProvider>().isDark;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 21.w,right: 19.w,top: 9.h,bottom: 9.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isDark ? Colors.black : AppColors.skipForNow
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(localeText(context, "you_can_always_change_goals_later"),style: TextStyle(
                fontSize: 10.sp,
              ),textAlign: TextAlign.center,
              ),
            ),
            Text(' | ${localeText(context, "skip_for_now")}',style: TextStyle(
              fontFamily: 'satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ))
          ],
        ),
      ),
    );
  }
}
