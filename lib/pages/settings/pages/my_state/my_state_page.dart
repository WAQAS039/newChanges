import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/widgets/achievement_section.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/widgets/average_stats_section.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/widgets/weekly_engagement_section.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/widgets/your_engagement_container.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';
import 'my_state_provider_updated.dart';

class MyStatePage extends StatefulWidget {
  const MyStatePage({Key? key}) : super(key: key);

  @override
  State<MyStatePage> createState() => _MyStatePageState();
}

class _MyStatePageState extends State<MyStatePage> {
  // double _value = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // Provider.of<MyStateProvider>(context,listen: false).getCurrentStreak();
      Provider.of<MyStateProvider>(context, listen: false)
          .getWeeklyAppEngagement();
      Provider.of<MyStateProvider>(context, listen: false)
          .getWeeklyPercentageDifference();
      // _value = Provider.of<MyStateProvider>(context,listen: false).streak!.secondsElapsed!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MyStateProvider>(context, listen: false)
            .startAppUsageTimer();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Stats",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        fontFamily: 'satoshi')),

                /// your engagement
                YourEngagementContainer(),

                /// average stats section
                AverageStatsSection(),

                /// weekly Engagement Section
                WeeklyEngagementSection(),

                /// achievement Section
                AchievementSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatDuration(Duration duration) {
  if (duration.inDays > 0) {
    final hours = duration.inHours - duration.inDays * 24;
    final minutes = duration.inMinutes - duration.inHours * 60;
    return '${duration.inDays}d${hours}h${minutes}m';
  } else if (duration.inSeconds <= 60) {
    return '${duration.inSeconds}s';
  } else if (duration.inSeconds >= 61 && duration.inMinutes <= 60) {
    return '${duration.inMinutes}m';
  } else {
    final hours = duration.inHours;
    final minutes = duration.inMinutes - duration.inHours * 60;
    return '${hours}h ${minutes}m';
  }
}
