import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/models/more.dart';
import 'package:nour_al_quran/pages/more/pages/qibla_direction/provider.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/provider/tasbeeh_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/settings/settings_page.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/title_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    // var them = context.read<ThemProvider>().isDark;
    List<More> pages = [
      More(
          name: localeText(context, "99_names_of_allah"),
          image: 'assets/images/app_icons/names_99.png'),
      More(
          name: localeText(context, 'qibla_direction'),
          image: 'assets/images/app_icons/qibla_direction.png'),
      More(
          name: localeText(context, 'step_by_step_salah'),
          image: 'assets/images/app_icons/step_by_step_salah.png'),
      More(
          name: localeText(context, 'salah_timer'),
          image: 'assets/images/app_icons/salah_timer.png'),
      More(
          name: localeText(context, 'shahada'),
          image: 'assets/images/app_icons/shahadah.png'),
      More(
          name: localeText(context, 'tasbeeh'),
          image: 'assets/images/app_icons/tasbeeh.png'),
      More(
          name: localeText(context, "quran_miracles"),
          image: 'assets/images/app_icons/miracles.png'),
      More(
          name: localeText(context, "islam_basics"),
          image: 'assets/images/app_icons/islam_basics.png'),
      More(
          name: localeText(context, "duas"),
          image: 'assets/images/app_icons/duas.png'),
      More(
          name: localeText(context, "hajjandumrah"),
          image: 'assets/images/app_icons/hajjandumrah.png'),
    ];
    List routes = [
      RouteHelper.namesOfALLAH,
      RouteHelper.qiblaDirection,
      RouteHelper.stepsOFPrayer,
      RouteHelper.salahTimer,
      RouteHelper.shahada,
      RouteHelper.tasbeeh,
      RouteHelper.miraclesOfQuran,
      RouteHelper.basicsOfQuran,
//RouteHelper.swipe,
      RouteHelper.duaMain,
    ];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                  left: 20.w, top: 60.h, bottom: 12.h, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(
                      title: localeText(context, "discover"),
                      style: TextStyle(
                          fontFamily: 'satoshi',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold)),
                  // InkWell(onTap: () {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => const SettingsPage()));
                  // }, child: Consumer<ThemProvider>(
                  //   builder: (context, them, child) {
                  //     return Image.asset(
                  //       'assets/images/app_icons/settings.png',
                  //       height: 16.5.h,
                  //       width: 16.5.w,
                  //       color: them.isDark ? Colors.white : Colors.black,
                  //     );
                  //   },
                  // ))
                ],
              )),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9.h,
                  crossAxisSpacing: 9.w,
                  mainAxisExtent: 120.h),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Consumer<QiblaProvider>(
                  builder: (context, qibla, child) {
                    return InkWell(
                      onTap: () async {
                        Future.delayed(
                            Duration.zero,
                            () => context
                                .read<RecitationPlayerProvider>()
                                .pause(context));
                        if (index == 1) {
                          if (mounted) {
                            if (Platform.isAndroid) {
                              bool? value = await FlutterQiblah
                                  .androidDeviceSensorSupport();
                              if (value!) {
                                Future.delayed(Duration.zero,
                                    () => qibla.getLocationPermission(context));
                              }
                            }
                            if (Platform.isIOS) {
                              Future.delayed(
                                  Duration.zero,
                                  () =>
                                      qibla.getLocationPermissionIOS(context));
                            } else {
                              Future.delayed(Duration.zero,
                                  () => qibla.getLocationPermission(context));
                            }
                          }
                        } else {
                          if (index == 5) {
                            Provider.of<TasbeehProvider>(context, listen: false)
                                .reset();
                          }
                          Navigator.of(context).pushNamed(routes[index]);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.grey5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<AppColorsProvider>(
                              builder: (context, value, child) => Image.asset(
                                pages[index].image!,
                                height: 55.h,
                                width: 55.w,
                                color: value.mainBrandingColor,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 14.h),
                                child: Text(
                                  pages[index].name!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'satoshi',
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
