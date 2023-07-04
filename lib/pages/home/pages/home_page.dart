import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/featured/pages/featured.dart';
import 'package:nour_al_quran/pages/home/widgets/featured_section.dart';
import 'package:nour_al_quran/pages/home/widgets/islam_basics_section.dart';
import 'package:nour_al_quran/pages/home/widgets/quran_miracles_section.dart';
import 'package:nour_al_quran/pages/home/widgets/quran_stories_section.dart';
import 'package:nour_al_quran/pages/home/widgets/user_picture.dart';
import 'package:nour_al_quran/pages/settings/pages/subscriptions/on_board/free_trial.dart';
import 'package:nour_al_quran/pages/trending/trending.dart';
import 'package:nour_al_quran/shared/entities/last_seen.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/pages/quran/pages/resume/where_you_left_off_widget.dart';
import '../widgets/verse_of_the_day.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LastSeen? lastSeen = Hive.box('myBox').get("lastSeen");

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 5),()=>showInAppPurchaseBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// user picture, home title and islamic date widget
            const UserPicture(),

            /// your engagement feature
            //const YourEngagementSection(),

            /// ayah last seen container
            lastSeen != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 20.w, bottom: 8.h, right: 20.w),
                        child: Text(
                          localeText(context, 'continue_where_you_left_off'),
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: 'satoshi',
                              fontWeight: FontWeight.w900),
                        )),
                  )
                : const SizedBox.shrink(),
            lastSeen != null
                ? const WhereULeftOffWidget()
                : const SizedBox.shrink(),
            const FeaturedSection(),
            const VerseOfTheDayContainer(),

            /// quran Stories Section
            const QuranStoriesSection(),

            /// verse of the day Container

            /// Quran Miracles Section
            const QuranMiraclesSection(),

            /// Islam Basics Section
            const IslamBasicsSection(),
          ],
        ),
      ),
    );
  }

  showInAppPurchaseBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return const FreeTrial();
      },
    );
  }
}
