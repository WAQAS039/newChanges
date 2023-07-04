import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

class BrandButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const BrandButton({Key? key,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Consumer<AppColorsProvider>(
        builder: (context, value, child) {
          return Container(
              height: 50.h,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: value.mainBrandingColor
              ),
              child: Text(text,style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'satoshi',
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),));
        },
      ),
    );
  }
}
