import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:nour_al_quran/pages/more/pages/salah_timer/provider.dart';
import 'package:nour_al_quran/pages/more/pages/salah_timer/salah.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class SalahTimerPage extends StatefulWidget {
  const SalahTimerPage({Key? key}) : super(key: key);

  @override
  State<SalahTimerPage> createState() => _SalahTimerPageState();
}

class _SalahTimerPageState extends State<SalahTimerPage> {
  @override
  void initState() {
    super.initState();
    context.read<PrayerTimeProvider>().checkLocationPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: localeText(context, "salah_timer"),
          icon: "yes"),
      body: Consumer3<ThemProvider, AppColorsProvider, PrayerTimeProvider>(
        builder: (context, them, appColor, prayerTimes, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 18.h, right: 20.w, left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${prayerTimes.address} (${DateFormat.jm().format(DateTime.now()).toString().toLowerCase()})',
                          style: TextStyle(
                              color: them.isDark
                                  ? AppColors.grey6
                                  : AppColors.grey1,
                              fontFamily: 'satoshi',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 14.h, top: 12.h),
                          child: Text(
                            '${LocalizationProvider().locale.languageCode == "ur" || LocalizationProvider().locale.languageCode == "ar" ? DateFormat("y d EEE", LocalizationProvider().locale.languageCode).format(DateTime.now()) : DateFormat("EEE d'th', y", LocalizationProvider().locale.languageCode).format(DateTime.now())} | ${HijriCalendar.now().toFormat(
                              "dd MMMM yyyy",
                            )}',
                            style: TextStyle(
                                color: them.isDark
                                    ? AppColors.grey5
                                    : AppColors.grey3,
                                fontFamily: 'satoshi',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage(
                                  'assets/images/app_icons/sunrise.png'),
                              size: 22.35.h,
                            ),
                            SizedBox(
                              width: 12.24.w,
                            ),
                            Text(
                              prayerTimes.sunRise,
                              style: TextStyle(
                                  fontFamily: 'satoshi',
                                  fontSize: 14.9.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 23.24.w,
                            ),
                            ImageIcon(
                              const AssetImage(
                                  'assets/images/app_icons/sunset.png'),
                              size: 22.35.h,
                            ),
                            SizedBox(
                              width: 12.24.w,
                            ),
                            Text(
                              prayerTimes.sunSet,
                              style: TextStyle(
                                  fontFamily: 'satoshi',
                                  fontSize: 14.9.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    )),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Salah prayer = prayerTimes.prayerTimesList.isNotEmpty
                          ? prayerTimes.prayerTimesList[index]
                          : Salah(
                              name: "",
                              time: "",
                              notify: false,
                              prayerTime: DateTime.now());
                      String prayerName =
                          prayer.name != null ? prayer.name!.toLowerCase() : "";
                      if (prayer.prayerTime!.isAfter(DateTime.now())) {
                        print(index);
                      }
                      return Container(
                        height: 105.h,
                        margin:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
                        padding: EdgeInsets.only(left: 9.36.w, right: 12.43.w),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/salah_timer/them_${prayerTimes.selectedThem == 2 ? "1" : "2"}/${index + 1}.webp')),
                            borderRadius: BorderRadius.circular(6.r)),
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(top: 8.06.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              prayerName != ""
                                                  ? localeText(
                                                      context,
                                                      prayer.name!
                                                          .toLowerCase())
                                                  : "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontFamily: 'satoshi',
                                                  fontWeight: FontWeight.w700)),
                                          Row(
                                            children: [
                                              index ==
                                                      prayerTimes
                                                          .upcomingPrayerIndex
                                                  ? Text(
                                                      prayerTimes.tempInC == ""
                                                          ? ""
                                                          : "${prayerTimes.tempInC}°C",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp,
                                                          fontFamily: 'satoshi',
                                                          fontWeight:
                                                              FontWeight.w700))
                                                  : const SizedBox.shrink(),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              index ==
                                                      prayerTimes
                                                          .upcomingPrayerIndex
                                                  ? prayerTimes.tempInC != ""
                                                      ? ImageIcon(
                                                          AssetImage(prayerTimes
                                                              .image),
                                                          size: 22.85.h,
                                                          color: Colors.white,
                                                        )
                                                      : const SizedBox.shrink()
                                                  : const SizedBox.shrink(),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    prayerTimes
                                                        .setPrayerNotification(
                                                            index);
                                                  },
                                                  child: ImageIcon(
                                                      AssetImage(
                                                          'assets/images/app_icons/${prayer.notify ?? false ? "notification" : "bell"}.png'),
                                                      size: 22.85.h,
                                                      color: Colors.white)),
                                            ],
                                          )
                                        ],
                                      ),
                                      Text(
                                        prayer.time ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontFamily: 'satoshi',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  String getTiming() {
    if (LocalizationProvider().locale.languageCode == "ur" ||
        LocalizationProvider().locale.languageCode == "ar") {
      return '${localeText(context, DateFormat("EEE").format(DateTime.now()).toLowerCase())} ${DateFormat("d, y").format(DateTime.now())} \n ${HijriCalendar.now().toFormat(
        "dd  ${localeText(context, HijriCalendar.now().longMonthName.toLowerCase())}  yyyy",
      )}';
    } else {
      return '${DateFormat("EEE d'th', y").format(DateTime.now())} | ${HijriCalendar.now().toFormat(
        "dd MMMM yyyy",
      )}';
    }
  }
}
