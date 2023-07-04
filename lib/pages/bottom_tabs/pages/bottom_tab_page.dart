import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/bottom_tabs/widgets/bottom_nav_widget.dart';
import 'package:nour_al_quran/pages/featured/provider/featured_provider.dart';
import 'package:nour_al_quran/pages/featured/provider/featurevideoProvider.dart';
import 'package:nour_al_quran/pages/home/provider/home_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/notifications/notification_services.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';
import 'package:provider/provider.dart';
import '../../basics_of_quran/provider/islam_basics_provider.dart';
import '../../miracles_of_quran/provider/miracles_of_quran_provider.dart';
import '../../quran stories/quran_stories_provider.dart';
import '../../settings/pages/my_state/my_state_provider_updated.dart';
import '../provider/bottom_tabs_page_provider.dart';

class BottomTabsPage extends StatefulWidget {
  const BottomTabsPage({Key? key}) : super(key: key);

  @override
  State<BottomTabsPage> createState() => _BottomTabsPageState();
}

class _BottomTabsPageState extends State<BottomTabsPage>
    with WidgetsBindingObserver {
  /// this is the main bottom tabs screen
  /// so in the init method of this we are initializing all important data belong to
  /// home screen to load all the data from home screen loads
  @override
  void initState() {
    super.initState();

    /// observer is used to observe app lifecycle state
    /// and it is used to stop and start app usage and other timers when user stop or resume the app
    WidgetsBinding.instance.addObserver(this);

    /// this method will get verse of the day
    context.read<HomeProvider>().getVerse(context);

    /// get all stores, miracles and islam basics from home.db file
    context.read<QuranStoriesProvider>().getStories();
    context.read<MiraclesOfQuranProvider>().getMiracles();
    context.read<IslamBasicsProvider>().getIslamBasics();
    context.read<FeatureProvider>().getStories();
    Provider.of<FeaturedMiraclesOfQuranProvider>(context, listen: false).getMiracles();

    /// this is app usage state provider which is used to stop and start timers
    var provider = context.read<MyStateProvider>();
    Future.delayed(Duration.zero, () {
      /// update streak will initialize and update current streak level
      /// if user is using app continuously every day without any gap so it will increment
      /// streak level by +1 every day if user come after 1 day gap so streak level will start
      /// again from zero
      provider.updateStreak();

      /// this method will get all the app usage seconds from the
      /// very first entry to end and will provide seconds as [total seconds]
      provider.getLifeTimeAppUsageSeconds();

      /// this method will start timer
      /// this timer is for app usage timer and this will only
      /// stop when user stop the app or pause the app other wise it will continuously run
      /// til user use the app
      provider.startAppUsageTimer();
    });

    setUpRecitationNotifications();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomTabsPageProvider>(
        builder: (context, value, child) {
          return value.page[value.currentPage];
        },
      ),
      bottomNavigationBar: BottomNavWidget(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var provider = Provider.of<MyStateProvider>(context, listen: false);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      provider.stopAllTimer();
    } else if (state == AppLifecycleState.resumed) {
      provider.startAppUsageTimer();
      provider.startQuranReadingTimer("home");
      provider.startQuranRecitationTimer("home");
    }
  }

  void setUpRecitationNotifications() {
    NotificationServices().dailyNotifications(
      id: dailyQuranRecitationId,
      title: 'Recitation Reminder',
      body: 'It is time to recite the Holy Quran',
      payload: 'recite',
      dailyNotifyTime: const TimeOfDay(hour: 8, minute: 0),
    );
  }
}
