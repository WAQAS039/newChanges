import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/featured/pages/featured.dart';
import 'package:nour_al_quran/pages/featured/pages/featured_content_page.dart';
import 'package:nour_al_quran/pages/featured/pages/featured_video.dart';
import 'package:nour_al_quran/pages/featured/widgets/featured_list.dart';
import 'package:nour_al_quran/pages/more/pages/names_of_allah/name_of_allah_page.dart';
import 'package:nour_al_quran/pages/more/pages/qibla_direction/qibla_direction.dart';
import 'package:nour_al_quran/pages/more/pages/salah_timer/salah_timer_page.dart';
import 'package:nour_al_quran/pages/more/pages/shahada/pages/shahada_page.dart';
import 'package:nour_al_quran/pages/more/pages/step_by_step_salah/steps_by_step_salah_page.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/pages/tasbeeh_page.dart';
import 'package:nour_al_quran/pages/onboarding/pages/index.dart';
import 'package:nour_al_quran/pages/paywall/paywallpage2.dart';
import 'package:nour_al_quran/pages/paywall/upgrade_to_premimum.dart';
import 'package:nour_al_quran/pages/quran%20stories/pages/quran_stories_page.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/audio_player_page.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/reciter_page.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/view_all/view_all.dart';
import 'package:nour_al_quran/pages/settings/pages/about_the_app/about_the_app_page.dart';
import 'package:nour_al_quran/pages/settings/pages/download_manager/reciter_download_surahs_page.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/fonts_page.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/my_state_page.dart';
import 'package:nour_al_quran/pages/settings/pages/notifications/notification_setting_page.dart';
import 'package:nour_al_quran/pages/settings/pages/privacy_policy/privacy_policy_page.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/edit_profile_page.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/manage_profile_page.dart';
import 'package:nour_al_quran/pages/settings/pages/report_an_issue/report_issue_page.dart';
import 'package:nour_al_quran/pages/settings/pages/subscriptions/manage_subscription_page.dart';
import 'package:nour_al_quran/pages/settings/pages/subscriptions/upgrade_to_premium_page.dart';
import 'package:nour_al_quran/pages/settings/pages/terms_of_service/terms_of_services_page.dart';
import 'package:nour_al_quran/pages/sign_in/pages/forgot_password_screen.dart';
import 'package:nour_al_quran/pages/sign_in/pages/sigin_page.dart';
import 'package:nour_al_quran/pages/sign_in/pages/sign_up_page.dart';
//import 'package:nour_al_quran/shared/widgets/easy_loading.dart';
import '../../pages/basics_of_quran/pages/basics_content_page.dart';
import '../../pages/basics_of_quran/pages/basics_of_quran_page.dart';
import '../../pages/bottom_tabs/pages/bottom_tab_page.dart';
import '../../pages/duas/dua_detailed.dart';
import '../../pages/duas/dua_page.dart';
import '../../pages/duas/duamain.dart';
import '../../pages/duas/widgets/dua_player_list.dart';
import '../../pages/qaida/screens/pageIndex.dart';
import '../../pages/quran stories/pages/story_content_page.dart';
import '../../pages/quran/pages/ruqyah/ruqyah_detailed.dart';
import '../../pages/quran/pages/ruqyah/ruqyah_page.dart';
import '../../pages/quran/pages/ruqyah/ruqyah_play_list.dart';
import '../utills/app_constants.dart';
import '../widgets/story_n_basics_player.dart';
import '../../pages/miracles_of_quran/pages/miracle_content_page.dart';
import '../../pages/miracles_of_quran/pages/miracles_of_quran_page.dart';
import 'package:nour_al_quran/pages/qaida/screens/swipe.dart';

class RouteHelper {
  static const String initRoute = "/";
  static const String achieveWithQuran = "/achieve";
  static const String reviewOne = "/reviewOne";
  static const String setFavReciter = "/setFavReciter";
  static const String paywallscreen = "/paywall";
  static const String paywallscreen2 = "/paywall2";
  static const String featured = "/featuredList";
  static const String featureDetails = "/featuredDetailPage";
  static late BuildContext currentContext;
  static bool paywallVisibility = true;

  // Variable to control visibility of paywallpage1
  //static bool showPaywallPage2 = true; // Variable to control visibility of paywallpage2
  //code to get paywall visibility bool true or false
  // Function to fetch the value of showPaywallPage1 from Firestore
  // static const String whenToRecite = "/whenToRecite";
  static const String quranReminder = "/quranReminder";
  // static const String setDailyQuranReadingTime = "/dailyQuran";
  static const String preferredLanguage = "setLanguage";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String yourName = "/yourName";
  static const String notificationSetup = "/notificationSetup";
  static const String application = "/bottom_tabs";
  static const String reciter = "/reciter";
  static const String dua = "/duas";
  static const String surah = "/surah";
  static const String shahada = "/shahada";
  static const String qiblaDirection = "/qibla";
  static const String namesOfALLAH = "/namesOfALLAH";
  static const String stepsOFPrayer = "/steps";
  static const String tasbeeh = "/tasbeeh";
  static const String salahTimer = "/salahTimer";
  static const String upgradeApp = "/upgradeApp";
  static const String managePremium = "/managePremium";
  static const String editProfile = "/editProfile";
  static const String manageProfile = "/manageProfile";
  static const String appFont = "/appFont";
  static const String allReciters = "allReciters";
  static const String audioPlayer = "/audioPlayer";
  static const String miraclesOfQuran = "/miracles";
  static const String miraclesDetails = "/miraclesDetail";
  // static const String chapterList = "/chapterList";
  static const String storyPlayer = "/storyPlayer";
  static const String storyDetails = "/storyDetail";
  static const String downloadedSurahManager = "/downloadSurahManager";
  static const String basicsOfQuran = "/quranBasics";
  static const String basicsOfIslamDetails = "/basicsOfIslamTopicDetails";
  static const String completeProfile = "/completeProfile";
  static const String reportIssue = "/reportIssue";
  static const String privacyPolicy = "/privacyPolicy";
  static const String termsOfServices = "/termsOfServices";
  static const String aboutApp = "/aboutApp";
  static const String notificationSetting = "notificationSetting";
  static const String myState = "myState";
  static const String swipe = "/swipe";
  static const String duaMain = "/duaMain";
  static const String duaDetailed = "/duaDetailed";
  static const String duaPlayList = "/duaPlayList";
  static const String forgetPassword = "/forgetPassword";
  static const String ruqyah = "/ruqyah";
  static const String ruqyahDetailed = "/ruqyahDetailed";
  static const String ruqyahPlayList = "/ruqyahPlayList";
  static const String quranstoriespage = "/quranStoriesPage";
  static const String qaidapageindex = "/qaidapageindex";
  static const String favortiesmiraclesDetails = "/favortiesmiraclesDetails";
  // static late BuildContext currentContext;
  static bool signInSkipped = false;
  static bool isLoggedIn = false;
  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      initRoute: (context) {
        String onBoardingDone =
            Hive.box(appBoxKey).get(onBoardingDoneKey) ?? "notDone";
        currentContext = context;
        return onBoardingDone == "done"
            ? const BottomTabsPage()
            : const SetPreferredLanguage();
      },
      achieveWithQuran: (context) {
        currentContext = context;
        return const AchieveWithQuranPage();
      },

      reviewOne: (context) {
        currentContext = context;
        return const ReviewOne();
      },
      swipe: (context) {
        currentContext = context;
        return const SwipePages(
          initialPage: 0,
          // swipePagesKey: GlobalKey<SwipePagesState>(),
        );
      },
      duaMain: (context) {
        currentContext = context;
        return const DuaCategoriesMain();
      },
      featured: (context) {
        currentContext = context;
        return const FeaturedPage();
      },
      duaDetailed: (context) {
        currentContext = context;
        return const DuaDetail();
      },
      qaidapageindex: (context) {
        currentContext = context;
        return QaidaPageIndex(
          selectedIndex: 0,
        );
      },
      featureDetails: (context) {
        currentContext = context;
        return const FeaturedDetailsPage();
      },
      ruqyahDetailed: (context) {
        currentContext = context;
        return const RuqyahDetail();
      },

      duaPlayList: (context) {
        currentContext = context;
        return const DuaPlayList();
      },
      quranstoriespage: (context) {
        currentContext = context;
        return const QuranStoriesPage();
      },
      ruqyahPlayList: (context) {
        currentContext = context;
        return const RuqyahPlayList();
      },
      paywallscreen: (context) {
        final paywallVisibilityFuture = () async {
          final connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            return false; // No internet connection, set paywallVisibility to false
          } else {
            final snapshot = await FirebaseFirestore.instance
                .collection('paywallsettings')
                .doc('hideunhide')
                .get();
            print(snapshot.data());
            if (snapshot.data() != null) {
              return snapshot.data()!['paywallVisibility'] as bool;
            } else {
              return true;
            }
          }
        }();

        return FutureBuilder<bool>(
          future: paywallVisibilityFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CompleteProfile();
              // return Container(
              //   color: Colors.white,
              //   child: const Center(
              //     child: CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         AppColors.mainBrandingColor,
              //       ),
              //     ),
              //   ),
              // );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final paywallVisibility = snapshot.data ?? true;
              if (paywallVisibility) {
                return paywall();
              } else {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushReplacementNamed('/signIn');
                });
                return const CompleteProfile();
              }
            }
          },
        );
      },
      paywallscreen2: (context) {
        currentContext = context;
        return const paywallpage2();
      },
      setFavReciter: (context) {
        currentContext = context;
        return const SetFavReciter();
      },
      // whenToRecite: (context) {
      //   currentContext = context;
      //   return const WhenToRecite();
      // },
      quranReminder: (context) {
        currentContext = context;
        return const QuranReminder();
      },
      // setDailyQuranReadingTime: (context) {
      //   currentContext = context;
      //   return const SetDailyQuranReadingTime();
      // },
      preferredLanguage: (context) {
        currentContext = context;
        return const SetPreferredLanguage();
      },
      signIn: (context) {
        currentContext = context;
        return const SignInPage();
      },
      signUp: (context) {
        currentContext = context;
        return const SignUpPage();
      },
      yourName: (context) {
        return const YourNamePage();
      },
      notificationSetup: (context) {
        currentContext = context;
        return const NotificationSetup();
      },
      application: (context) {
        currentContext = context;
        return const BottomTabsPage();
      },
      reciter: (context) {
        currentContext = context;
        return const ReciterPage();
      },
      dua: (context) {
        currentContext = context;
        return const DuaPage();
      },
      ruqyah: (context) {
        currentContext = context;
        return const RuqyahPage();
      },

      shahada: (context) {
        currentContext = context;
        return const ShahadahPage();
      },
      qiblaDirection: (context) {
        currentContext = context;
        return const QiblaDirectionPage();
      },
      namesOfALLAH: (context) {
        currentContext = context;
        return const NamesOfALLAHPage();
      },
      stepsOFPrayer: (context) {
        currentContext = context;
        return const StepByStepSalahPage();
      },
      tasbeeh: (context) {
        currentContext = context;
        return const TasbeehPage();
      },
      salahTimer: (context) {
        currentContext = context;
        return const SalahTimerPage();
      },
      upgradeApp: (context) {
        currentContext = context;
        return const UpgradeToPremiumPage();
      },
      managePremium: (context) {
        currentContext = context;
        return const ManageSubscriptionPage();
      },
      editProfile: (context) {
        currentContext = context;
        return EditProfilepage();
      },
      manageProfile: (context) {
        currentContext = context;
        return const ManageProfile();
      },
      appFont: (context) {
        currentContext = context;
        return const FontPage();
      },
      allReciters: (context) {
        currentContext = context;
        return const AllReciters();
      },
      audioPlayer: (context) {
        currentContext = context;
        return const AudioPlayerPage();
      },
      miraclesOfQuran: (context) {
        currentContext = context;
        return const MiraclesOfQuranPage();
      },
      miraclesDetails: (context) {
        currentContext = context;
        return const MiraclesDetailsPage();
      },
      favortiesmiraclesDetails: (context) {
        currentContext = context;
        return const FavoriteMiraclesDetailsPage();
      },
      // chapterList: (context) {
      //   currentContext = context;
      //   return const ChaptersPage();
      // },
      storyDetails: (context) {
        currentContext = context;
        return const StoryDetailsPage();
      },
      storyPlayer: (context) {
        currentContext = context;
        return const StoryAndBasicsAudioPlayer();
      },
      downloadedSurahManager: (context) {
        currentContext = context;
        return const ReciterDownloadSurahPage();
      },
      basicsOfQuran: (context) {
        currentContext = context;
        return const BasicsOfQuranPage();
      },
      basicsOfIslamDetails: (context) {
        currentContext = context;
        return const IslamBasicDetailsPage();
      },
      completeProfile: (context) {
        currentContext = context;
        return const CompleteProfile();
      },
      reportIssue: (context) {
        currentContext = context;
        return const ReportIssuePage();
      },
      privacyPolicy: (context) {
        currentContext = context;
        return const PrivacyPolicyPage();
      },

      termsOfServices: (context) {
        currentContext = context;
        return const TermsOfServicesPage();
      },
      aboutApp: (context) {
        currentContext = context;
        return const AboutTheAppPage();
      },
      notificationSetting: (context) {
        currentContext = context;
        return const NotificationSettingPage();
      },
      myState: (context) {
        currentContext = context;
        return const MyStatePage();
      },
      forgetPassword: (context) {
        currentContext = context;
        return const ForgotPasswordPage();
      }
    };
  }
}
