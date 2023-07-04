import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/provider/tasbeeh_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';

class TasbeehListSection extends StatelessWidget {
  const TasbeehListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = Provider.of<AppColorsProvider>(context,listen: false);
    var language = Provider.of<LocalizationProvider>(context,listen: false);
    var them = Provider.of<ThemProvider>(context,listen: false);
    return Consumer<TasbeehProvider>(
      builder: (context, tasbeehValue, child) {
        return Container(
          margin: EdgeInsets.only(top: 35.h, left: 20.w, right: 20.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                tasbeehValue.tasbeehList.length, (index) => Expanded(
              child: InkWell(
                onTap: () {
                  tasbeehValue.setCurrentTasbeeh(index);
                },
                child: Container(
                  margin: EdgeInsets.only(right: language.locale.languageCode == "ur" || language.locale.languageCode == "ar" ? index == 0 ? 0:6.w : index == 2 ? 0 :6.w),
                  padding: EdgeInsets.only(top: 7.h, bottom: 10.h),
                  decoration: BoxDecoration(color: tasbeehValue.currentTabeeh == index ? appColors.mainBrandingColor : them.isDark ? AppColors.darkColor : Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 12,
                            color: Color.fromRGBO(0, 0, 0, 0.08))
                      ]),
                  child: Column(
                    children: [
                      Text(
                        tasbeehValue.tasbeehList[index].arabicName,
                        style: TextStyle(
                            color: them.isDark ? Colors.white : tasbeehValue.currentTabeeh == index ? Colors.white : Colors.black,
                            fontFamily: 'Al Majeed Quranic Font',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(localeText(context, tasbeehValue.tasbeehList[index].englishName),
                          style: TextStyle(
                              color: tasbeehValue.currentTabeeh== index ? Colors.white : them.isDark ? Colors.white : Colors.black,
                              fontFamily: 'satoshi',
                              fontSize: 8.sp))
                    ],
                  ),
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
