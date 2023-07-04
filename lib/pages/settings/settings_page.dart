import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/app_them_page.dart';
import 'package:nour_al_quran/pages/settings/pages/app_translation.dart';
import 'package:nour_al_quran/pages/settings/pages/download_manager/download_manager_page.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/profile_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translations_manager_page.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_bottom_sheet.dart';
import 'package:nour_al_quran/pages/settings/widgets/setting_options.dart';
import 'package:nour_al_quran/pages/sign_in/provider/sign_in_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context: context, title: localeText(context, "settings")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin:
                          EdgeInsets.only(left: 20.w, top: 16.h, right: 20.w),
                      child: Text(
                        localeText(context, "app_experience"),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'satoshi',
                            fontSize: 15.sp),
                      )),
                  SettingOptions(
                    title: localeText(context, "upgrade_app_experience"),
                    subTitle: localeText(context, "manage_subscriptions"),
                    icon: "premium.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteHelper.upgradeApp);
                    },
                  ),
                  // Consumer<ProfileProvider>(
                  //   builder: (context, value, child) {
                  //     return SettingOptions(
                  //       title: localeText(context, "edit_profile"),
                  //       subTitle: value.userProfile != null
                  //           ? "Logged in as ${value.userProfile!.fullName}"
                  //           : "",
                  //       icon: "edit.png",
                  //       trailing: Icon(
                  //         Icons.arrow_forward_ios,
                  //         size: 12.h,
                  //       ),
                  //       onTap: () {
                  //         var loginStatus =
                  //             Hive.box(appBoxKey).get(loginStatusString) ?? 0;
                  //         Provider.of<ProfileProvider>(context, listen: false)
                  //             .setFromWhere("home");
                  //         Navigator.of(context).pushNamed(loginStatus != 0
                  //             ? RouteHelper.manageProfile
                  //             : RouteHelper.signIn);
                  //       },
                  //     );
                  //   },
                  // ),
                  // SettingOptions(
                  //   title: localeText(context, "my_stats"),
                  //   subTitle: localeText(context, "your_app_engagement_stats"),
                  //   icon: "theme.png",
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 12.h,
                  //   ),
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed(RouteHelper.myState);
                  //     // Navigator.of(context).push(MaterialPageRoute(builder: (context){));
                  //   },
                  // ),
                  SettingOptions(
                    title: localeText(context, "app_theme"),
                    subTitle: localeText(context, "choose_dark_or_light_mode"),
                    icon: "theme.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const AppThemPage();
                        },
                      ));
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "app_colors"),
                    icon: "colors.png",
                    trailing: Consumer<AppColorsProvider>(
                      builder: (context, value, child) {
                        return Icon(
                          Icons.circle,
                          size: 14.h,
                          color: value.mainBrandingColor,
                        );
                      },
                    ),
                    onTap: () {
                      showImagesBottomSheet(context);
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "app_font"),
                    icon: "app_fonts.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteHelper.appFont);
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "translation_manager"),
                    icon: "translation_manager.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const TranslationManagerPage();
                        },
                      ));
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "download_manager"),
                    icon: "download_manager.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          Future.delayed(
                              Duration.zero,
                              () => context
                                  .read<RecitationPlayerProvider>()
                                  .closePlayer());
                          return const DownloadManagerPage();
                        },
                      ));
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "app_language"),
                    icon: "app_language.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const AppTranslationPage();
                        },
                      ));
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "notifications"),
                    icon: "notification.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteHelper.notificationSetting);
                    },
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(left: 20.w, top: 23.4.h, right: 20.w),
                      child: Text(
                        localeText(context, "app_support"),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'satoshi',
                            fontSize: 12.sp),
                      )),
                  SettingOptions(
                    title: localeText(context, "report_an_issue"),
                    icon: "report.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteHelper.reportIssue);
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "privacy_policy"),
                    icon: "privacy_policy.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteHelper.privacyPolicy);
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "terms_of_service"),
                    icon: "terms_of_service.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteHelper.termsOfServices);
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "about_the_app"),
                    icon: "about.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteHelper.aboutApp);
                    },
                  ),
                  SettingOptions(
                    title: localeText(context, "share"),
                    icon: "share.png",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.h,
                    ),
                    onTap: () async {
                      await Share.share("app Url");
                    },
                  ),
                  Consumer2<SignInProvider, ProfileProvider>(
                    builder: (context, login, profile, child) {
                      return profile.userProfile != null
                          ? SettingOptions(
                              title: localeText(context, "logout"),
                              icon: "logout.png",
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 12.h,
                              ),
                              onTap: () async {
                                if (profile.userProfile!.loginType ==
                                    "google") {
                                  profile.resetUserProfile();
                                  await login.signOutFromGoogle();
                                } else if (profile.userProfile!.loginType ==
                                    "facebook") {
                                  profile.resetUserProfile();
                                } else {
                                  profile.resetUserProfile();
                                  await login.signOutFromEmailPassword();
                                }

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouteHelper.signIn,
                                  (Route<dynamic> route) => false,
                                );
                              },
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
