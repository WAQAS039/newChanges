import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/global.dart';
import 'package:nour_al_quran/pages/basics_of_quran/provider/islam_basics_provider.dart';
import 'package:nour_al_quran/pages/bottom_tabs/provider/bottom_tabs_page_provider.dart';
import 'package:nour_al_quran/pages/duas/dua_bookmarks_provider.dart';
import 'package:nour_al_quran/pages/duas/dua_provider.dart';
import 'package:nour_al_quran/pages/duas/widgets/ruqyah_bookmark_provider.dart';
import 'package:nour_al_quran/pages/home/provider/home_provider.dart';
import 'package:nour_al_quran/pages/onesginalnotify/provider.dart';

import 'package:nour_al_quran/pages/qaida/providers/audiolist_provider.dart';
import 'package:nour_al_quran/pages/quran%20stories/quran_stories_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/ruqyah/models/ruqyah_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/surah/lastreadprovider.dart';
import 'package:nour_al_quran/pages/quran/pages/surah/provider.dart';
import 'package:nour_al_quran/shared/providers/dua_audio_player_provider.dart';
import 'package:nour_al_quran/shared/providers/story_n_basics_audio_player_provider.dart';
import 'package:nour_al_quran/pages/miracles_of_quran/provider/miracles_of_quran_provider.dart';
import 'package:nour_al_quran/pages/more/pages/names_of_allah/names_provider.dart';
import 'package:nour_al_quran/pages/more/pages/qibla_direction/provider.dart';
import 'package:nour_al_quran/pages/more/pages/salah_timer/provider.dart';
import 'package:nour_al_quran/pages/more/pages/step_by_step_salah/salah_steps_provider.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/provider/tasbeeh_provider.dart';
import 'package:nour_al_quran/pages/onboarding/on_boarding_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/bookmarks/bookmarks_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/juz/juz_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/reciter_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/surah/surah_provider.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/download_manager/download_manager_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/my_state_provider_updated.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/profile_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translation_manager_provider.dart';
import 'package:nour_al_quran/pages/sign_in/provider/sign_in_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_demo.dart';
import 'package:nour_al_quran/shared/network/network_provider.dart';
import 'package:nour_al_quran/shared/providers/download_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/resume/last_seen_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_them.dart';
import 'package:nour_al_quran/shared/utills/dimensions.dart';
import 'package:provider/provider.dart';

import 'pages/featured/provider/featured_provider.dart';
import 'pages/featured/provider/featurevideoProvider.dart';
import 'pages/paywall/paywal_provider.dart';

void main() async {
  await Global.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FeatureProvider()),
    ChangeNotifierProvider(create: (_) => PremiumScreenProvider()),
    ChangeNotifierProvider(create: (_) => recentProvider()),
    ChangeNotifierProvider(create: (_) => LastReadProvider()),
    ChangeNotifierProvider(create: (_) => ThemProvider()),
    ChangeNotifierProvider(create: (_) => BottomTabsPageProvider()),
    ChangeNotifierProvider(create: (_) => QuranProvider()),
    ChangeNotifierProvider(create: (_) => TasbeehProvider()),
    ChangeNotifierProvider(create: (_) => LocalizationProvider()),
    ChangeNotifierProvider(create: (_) => ReciterProvider()),
    ChangeNotifierProvider(create: (_) => DownloadProvider()),
    ChangeNotifierProvider(create: (_) => RecitationPlayerProvider()),
    ChangeNotifierProvider(create: (_) => AppColorsProvider()),
    ChangeNotifierProvider(create: (_) => PrayerTimeProvider()),
    ChangeNotifierProvider(create: (_) => QiblaProvider()),
    ChangeNotifierProvider(create: (_) => LastSeenProvider()),
    ChangeNotifierProvider(create: (_) => AudioListProvider()),
    ChangeNotifierProvider(create: (_) => BookmarkProvider()),
    ChangeNotifierProvider(create: (_) => SurahProvider()),
    ChangeNotifierProvider(create: (_) => JuzProvider()),
    ChangeNotifierProvider(create: (_) => DuaProvider()),
    ChangeNotifierProvider(create: (_) => RuqyahProvider()),
    ChangeNotifierProvider(create: (_) => RecitationProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
    ChangeNotifierProvider(create: (_) => FontProvider()),
    ChangeNotifierProvider(create: (_) => QuranStoriesProvider()),
    ChangeNotifierProvider(create: (_) => MiraclesOfQuranProvider()),
    ChangeNotifierProvider(create: (_) => TranslationManagerProvider()),
    ChangeNotifierProvider(create: (_) => DownloadManagerProvider()),
    ChangeNotifierProvider(create: (_) => SalahStepsProvider()),
    ChangeNotifierProvider(create: (_) => IslamBasicsProvider()),
    ChangeNotifierProvider(create: (_) => NamesProvider()),
    ChangeNotifierProvider(create: (_) => SignInProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => StoryAndBasicPlayerProvider()),
    ChangeNotifierProvider(create: (_) => MyStateProvider()),
    ChangeNotifierProvider(create: (_) => DuaPlayerProvider()),
    ChangeNotifierProvider(create: (_) => OneSignalProvider()),
    ChangeNotifierProvider(create: (_) => BookmarkProviderDua()),
    ChangeNotifierProvider(create: (_) => BookmarkProviderRuqyah()),
    ChangeNotifierProvider(create: (_) => FeaturedMiraclesOfQuranProvider()),
    StreamProvider<int>(
        create: (context) => NetworkProvider().streamController.stream,
        initialData: 0),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //onsignal notification code :
    final oneSignalProvider = Provider.of<OneSignalProvider>(context);
    // Initialize OneSignal
    oneSignalProvider.initializeOneSignal();
    return ScreenUtilInit(
      designSize: Size(Dimensions.width, Dimensions.height),
      builder: (BuildContext context, Widget? child) {
        return Consumer2<LocalizationProvider, ThemProvider>(
          builder: (context, value, dark, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: value.locale,
              localizationsDelegates: [
                LocalizationDemo.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: supportedLocales,
              localeResolutionCallback: localeResolutionCallback,
              themeMode: dark.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: AppThem.light,
              darkTheme: AppThem.dark,
              initialRoute: RouteHelper.initRoute,
              routes: RouteHelper.routes(context),
              // home: const TestingQuran(),
            );
          },
        );
      },
    );
  }
}
