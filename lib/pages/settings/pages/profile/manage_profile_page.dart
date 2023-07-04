import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/bookmarks/bookmark_page.dart';
import 'package:nour_al_quran/pages/quran/pages/juz/juz_Index_page.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_page.dart';
import 'package:nour_al_quran/pages/quran/pages/surah/surah_index_page.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/my_state_page.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/profile_provider.dart';
import 'package:nour_al_quran/shared/localization/languages.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    var pageNames = [
      localeText(context, "dashboard"),
      localeText(context, "library"),
      localeText(context, "history"),
      // localeText(context, "resume"),
      // localeText(context, "bookmarks"),
      // localeText(context, "duas"),
      // localeText(context, "favorites")
    ];

    var them = context.read<ThemProvider>().isDark;
    var style12 = TextStyle(
        fontFamily: 'satoshi',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: them ? Colors.white : Colors.black);
    var style400 = TextStyle(
        fontFamily: 'satoshi',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: them ? AppColors.grey4 : AppColors.grey2);
    return Scaffold(
      appBar: appbarformanageprofile(
          context: context,
          title: localeText(context, "manage_profile"),
          icon: ""),
      body: Consumer2<QuranProvider, AppColorsProvider>(
          builder: (context, value, appColors, child) {
        return Column(
          children: [
            Container(
              height: 23.h,
              margin: EdgeInsets.only(bottom: 15.h),
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                controller: scrollController,
                itemCount: pageNames.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      context.read<QuranProvider>().setCurrentPage(index);
                    },
                    child: Container(
                      height: 23.h,
                      padding: EdgeInsets.only(left: 9.w, right: 9.w),
                      margin: EdgeInsets.only(right: 7.w),
                      decoration: BoxDecoration(
                        color: index == value.currentPage
                            ? appColors.mainBrandingColor
                            : AppColors.grey6,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          pageNames[index],
                          style: TextStyle(
                            color: index == value.currentPage
                                ? Colors.white
                                : AppColors.grey3,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'satoshi',
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Expanded(child: pages[value.currentPage]),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<ProfileProvider>(
                  builder: (context, profile, child) {
                    if (profile.userProfile == null) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 200.h),
                          child: Text("Sign-in to get Started!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'satoshi',
                                  fontSize: 17.sp)),
                        ),
                      );
                    }
                    return Container(
                      margin:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  localeText(context, 'full_name'),
                                  style: style400,
                                ),
                                Text(
                                  profile.userProfile!.fullName ?? "",
                                  style: style12,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localeText(context, 'email_address'),
                                style: style400,
                              ),
                              Text(
                                profile.userProfile!.email ?? "",
                                style: style12,
                              ),
                            ],
                          ),

                          // profile.userProfile!.loginType != "google"
                          //     ? Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             'Password',
                          //             style: style400,
                          //           ),
                          //           Text(profile.userProfile!.password ?? "",
                          //               style: style12),
                          //         ],
                          //       )
                          //     : const SizedBox.shrink(),
                          // profile.userProfile!.loginType != "google"
                          //     ? SizedBox(
                          //         height: 16.h,
                          //       )
                          //     : const SizedBox.shrink(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localeText(context, 'preferred_app_language'),
                                style: style400,
                              ),
                              DropdownButton<Languages>(
                                underline: const SizedBox.shrink(),
                                style: style12,
                                value: profile.languages,
                                items: Languages.languages
                                    .map<DropdownMenuItem<Languages>>((e) =>
                                        DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                                localeText(context, e.name))))
                                    .toList(),
                                onChanged: (value) {
                                  profile.updatePreferredLanguage(value!);
                                  context
                                      .read<LocalizationProvider>()
                                      .setLocale(value!);
                                },
                              ),
                            ],
                          ),
                          BrandButton(
                              text: localeText(context, "edit_profile"),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteHelper.editProfile);
                              }),
                          SizedBox(height: 20.h),
                          BrandButton(
                            text: localeText(context, "delete_profile"),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete Profile"),
                                    content: const Text(
                                        "Are you sure you want to delete your profile?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Delete"),
                                        onPressed: () {
                                          // Call the delete method from the ProfileProvider
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .deleteUserProfile();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          Consumer<AppColorsProvider>(
                              builder: (context, value, child) {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.w),
                                child: InkWell(
                                  child: Text(
                                    localeText(context, "clear_userdata"),
                                    style: TextStyle(
                                      color: value.mainBrandingColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      fontFamily: 'satoshi',
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Clear Data"),
                                          content: const Text(
                                              "Are you sure you want to Clear data?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text("Delete"),
                                              onPressed: () {
                                                // Call the delete method from the ProfileProvider
                                                Provider.of<ProfileProvider>(
                                                        context,
                                                        listen: false)
                                                    .clearAppDataAndStorage(
                                                        context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(localeText(context, 'logged_in_devices'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  fontFamily: 'satoshi')),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Consumer<AppColorsProvider>(
                                    builder: (context, appColors, child) {
                                      return Container(
                                        height: 38.h,
                                        width: 38.w,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.67.h,
                                            horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          color: appColors.mainBrandingColor,
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                        child: Image.asset(
                                          'assets/images/app_icons/smartphone.png',
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          profile.userProfile!.loginDevices![0]
                                              .name!,
                                          style: style12),
                                      Text(
                                        'Logged in at 22-12-22 | 04:28 pm',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.sp,
                                            fontFamily: 'satoshi',
                                            color: them
                                                ? AppColors.grey4
                                                : AppColors.grey3),
                                      ),
                                    ],
                                  ),
                                  // Add MyStatePage widget
                                ],
                              ),

                              // Container(
                              //   padding: EdgeInsets.symmetric(vertical: 2.84.h,horizontal: 6.38.w),
                              //   alignment: Alignment.center,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(8.51.r),
                              //       border: Border.all(color: them ? AppColors.grey2:AppColors.grey4)
                              //   ),
                              //   child: Text("Remove Device",style: TextStyle(
                              //       fontWeight: FontWeight.w500,fontSize: 7.8.sp,fontFamily: 'satoshi'
                              //   ),),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ), // Add additional spacing if needed
                          const Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: 700,
                              width: double.infinity,
                              child: MyStatePage(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
