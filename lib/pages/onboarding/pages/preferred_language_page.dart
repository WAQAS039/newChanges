import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/bottom_tabs/pages/bottom_tab_page.dart';
import 'package:nour_al_quran/pages/onboarding/on_boarding_provider.dart';
import 'package:nour_al_quran/pages/onboarding/widgets/on_boarding_text_widgets.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/sign_in/pages/sigin_page.dart';
import 'package:nour_al_quran/shared/localization/languages.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../shared/entities/last_seen.dart';
import '../../bottom_tabs/provider/bottom_tabs_page_provider.dart';
import '../../quran/providers/quran_provider.dart';
import '../../quran/widgets/quran_text_view.dart';
import '../../settings/pages/notifications/notification_services.dart';

class SetPreferredLanguage extends StatefulWidget {
  const SetPreferredLanguage({Key? key}) : super(key: key);

  @override
  State<SetPreferredLanguage> createState() => _SetPreferredLanguageState();
}

class _SetPreferredLanguageState extends State<SetPreferredLanguage> {
  bool _isListening = false;

  String onBoardingDone =
      Hive.box(appBoxKey).get(onBoardingDoneKey) ?? "notDone";

  @override
  void initState() {
    super.initState();
    listenToNotification();
    print(onBoardingDone);
  }

  void gotoQuranTextView() {
    LastSeen? lastSeen = Hive.box('myBox').get("lastSeen");
    if (lastSeen != null) {
      if (lastSeen.isJuz!) {
        RouteHelper.currentContext.read<QuranProvider>().setJuzText(
              juzId: lastSeen.juzId!,
              title: lastSeen.juzArabic!,
              fromWhere: 0,
              isJuz: true,
            );
        Navigator.of(RouteHelper.currentContext)
            .pushNamedAndRemoveUntil(RouteHelper.application, (route) => false);
        Navigator.of(RouteHelper.currentContext).push(MaterialPageRoute(
          builder: (context) {
            return const QuranTextView();
          },
        ));
      } else {
        // coming from surah so isJuz already false
        // coming from surah so JuzId already -1
        RouteHelper.currentContext.read<QuranProvider>().setSurahText(
            surahId: lastSeen.surahId!,
            title: 'سورة ${lastSeen.surahNameArabic}',
            fromWhere: 0);
        Navigator.of(RouteHelper.currentContext)
            .pushNamedAndRemoveUntil(RouteHelper.application, (route) => false);
        Navigator.of(RouteHelper.currentContext).push(MaterialPageRoute(
          builder: (context) {
            return const QuranTextView();
          },
        ));
      }
    } else {
      RouteHelper.currentContext
          .read<QuranProvider>()
          .setSurahText(surahId: 1, title: 'سورةالفاتحة', fromWhere: 1);
      Navigator.of(RouteHelper.currentContext)
          .pushNamedAndRemoveUntil(RouteHelper.application, (route) => false);
      Navigator.of(RouteHelper.currentContext).push(MaterialPageRoute(
        builder: (context) {
          return const QuranTextView();
        },
      ));
    }
  }

  void listenToNotification() {
    NotificationServices.onNotification.stream.listen((event) {
      if (event != null) {
        _isListening = true;
        // Fluttertoast.showToast(msg: "listening");
        notificationOnClick(event);
      } else {
        // Fluttertoast.showToast(msg: "Not listening");
        _isListening = false;
      }
    });
  }

  notificationOnClick(String payload) {
    if (payload == "recite") {
      gotoQuranTextView();
    } else if (payload == "dua") {
      RouteHelper.currentContext
          .read<BottomTabsPageProvider>()
          .setCurrentPage(0);
      Navigator.of(RouteHelper.currentContext)
          .pushNamedAndRemoveUntil(RouteHelper.application, (route) => false);
    } else {
      Navigator.of(RouteHelper.currentContext)
          .pushNamedAndRemoveUntil(RouteHelper.application, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    int? loginStatus = Hive.box(appBoxKey).get(loginStatusString);
    var isDark = context.read<ThemProvider>().isDark;
    var appColors = context.read<AppColorsProvider>();
    return Scaffold(
      /// middleware to check where to do
      /// this is for notification this page must be called once to init the rx listener
      /// in order to listen to notifications
      body: onBoardingDone == "done"
          ? loginStatus == 1
              ? const BottomTabsPage()
              : const SignInPage()
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Consumer<LocalizationProvider>(
                    builder: (context, localization, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OnBoardingTitleText(
                              title: localeText(
                                  context, "choose_your_preferred_language")),
                          OnBoardingSubTitleText(
                              title: localeText(context,
                                  "let's_personalize_the_app_experience")),
                          _buildLanguageList(
                              context, localization, isDark, appColors),
                          SizedBox(
                            height: 6.h,
                          ),
                          Consumer<OnBoardingProvider>(
                            builder: (context, value, child) {
                              return BrandButton(
                                  text: localeText(context, "continue"),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteHelper.achieveWithQuran);
                                  });
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }

  _buildLanguageList(BuildContext context, LocalizationProvider localization,
      bool isDark, AppColorsProvider appColors) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: ListView.builder(
        itemCount: Languages.languages.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Languages lang = Languages.languages[index];
          return InkWell(
            onTap: () {
              localization.setLocale(lang);
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: 10.h,
              ),
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 15.h, bottom: 15.h),
              decoration: BoxDecoration(
                color: localization.locale.languageCode == lang.languageCode
                    ? isDark
                        ? AppColors.brandingDark
                        : AppColors.lightBrandingColor
                    : Colors.transparent,
                border: Border.all(
                    color: localization.locale.languageCode == lang.languageCode
                        ? appColors.mainBrandingColor
                        : isDark
                            ? AppColors.grey3
                            : AppColors.grey5),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localeText(context, lang.name),
                    style: TextStyle(
                        fontFamily: 'satoshi',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    localization.locale.languageCode == lang.languageCode
                        ? Icons.check_circle
                        : Icons.circle,
                    size: 17.h,
                    color: localization.locale.languageCode == lang.languageCode
                        ? isDark
                            ? Colors.white
                            : appColors.mainBrandingColor
                        : AppColors.grey5,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
