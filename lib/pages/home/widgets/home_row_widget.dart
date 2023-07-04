import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/app_text_widgets.dart';
import 'package:provider/provider.dart';

class HomeRowWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onTap;
  const HomeRowWidget(
      {Key? key,
      required this.text,
      required this.buttonText,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: 20.w, bottom: 8.h, right: 20.4.w, top: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text14(title: text),
          Consumer<AppColorsProvider>(
            builder: (context, value, child) {
              return InkWell(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 8.w, right: 8.w, top: 3.5.h, bottom: 3.5.h),
                  decoration: BoxDecoration(
                      color: value.mainBrandingColor,
                      borderRadius: BorderRadius.circular(8.50674.r)),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'satoshi'),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
