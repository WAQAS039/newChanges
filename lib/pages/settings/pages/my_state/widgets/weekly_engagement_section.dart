import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/my_state_page.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../my_state_provider_updated.dart';

class WeeklyEngagementSection extends StatelessWidget {
  const WeeklyEngagementSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppColorsProvider,MyStateProvider>(
      builder: (context, appColor, myState, child) {
        return myState.weeklyAppUsageList.isNotEmpty ? Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.only(top: 10.h,left: 9.w,right: 9.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColors.grey5)
          ),
          height: 162.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localeText(context, "weekly_app_engagement"),style: TextStyle(fontFamily: 'satoshi',fontSize: 12.sp,fontWeight: FontWeight.w700),),
                  Text("${localeText(context, "average")} ${formatDuration(Duration(seconds: myState.averageTimePerDay))} ${localeText(context, "per_day")}",style: TextStyle(fontFamily: 'satoshi',fontSize: 12.sp,fontWeight: FontWeight.w700,color: appColor.mainBrandingColor),),
                ],
              ),
              Container(
                height: 115.h,
                margin: EdgeInsets.only(top: 15.h),
                child: BarChart(
                    BarChartData(
                        minY: 0,
                        gridData: FlGridData(
                            show: false
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: const Border(bottom: BorderSide(color: AppColors.grey5))
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: getTitles
                              )
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 35.w,
                              getTitlesWidget: getTitlesForMin,
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)
                          ),
                        ),
                        barGroups: [
                          buildBarChartGroupData(1, myState.weeklyAppUsageList[0].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                          buildBarChartGroupData(2, myState.weeklyAppUsageList[1].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                          buildBarChartGroupData(3, myState.weeklyAppUsageList[2].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                          buildBarChartGroupData(4, myState.weeklyAppUsageList[3].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                          buildBarChartGroupData(5, myState.weeklyAppUsageList[4].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                          buildBarChartGroupData(6, myState.weeklyAppUsageList[5].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                          buildBarChartGroupData(7, myState.weeklyAppUsageList[6].secondsElapsed!.toDouble(),appColor.mainBrandingColor),
                        ])
                ),
              ),
            ],
          ),
        ) : const SizedBox.shrink();
      },
    );
  }

  buildBarChartGroupData(int x,double y,Color appColor){
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
            toY: y,
            color: appColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.r),topLeft: Radius.circular(30.r)),
            width: 12.w
        ),],);
  }






  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: AppColors.grey5,
      fontWeight: FontWeight.w400,
      fontSize: 11.sp,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('M', style: style);
        break;
      case 2:
        text = Text('T', style: style);
        break;
      case 3:
        text = Text('W', style: style);
        break;
      case 4:
        text = Text('T', style: style);
        break;
      case 5:
        text = Text('F', style: style);
        break;
      case 6:
        text = Text('S', style: style);
        break;
      case 7:
        text = Text('S', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: text,
    );
  }

  Widget getTitlesForMin(double value, TitleMeta meta) {
    var style = TextStyle(
      color: AppColors.grey5,
      fontWeight: FontWeight.w400,
      fontSize: 11.sp,
    );
    Widget text;
    text = Text(formatDuration(Duration(seconds: value.toInt())), style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }
}
