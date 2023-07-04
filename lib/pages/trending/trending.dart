import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/home/widgets/home_row_widget.dart';
import 'package:nour_al_quran/pages/quran%20stories/quran_stories_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:provider/provider.dart';

import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';

import '../../../shared/localization/localization_constants.dart';

import 'package:nour_al_quran/pages/bottom_tabs/provider/bottom_tabs_page_provider.dart';

import 'package:nour_al_quran/pages/quran stories/models/quran_stories.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int network = Provider.of<int>(context);
    return Column(
      children: [
        HomeRowWidget(
          text: localeText(context, 'trending'),
          buttonText: localeText(context, "view_all"),
          onTap: () {
            Navigator.of(context).pushNamed(RouteHelper.quranstoriespage);
          },
        ),
        Consumer<LocalizationProvider>(
          builder: (context, language, child) {
            return SizedBox(
              height: 150.h,
              child: Consumer<QuranStoriesProvider>(
                builder: (context, storiesProvider, child) {
                  return ListView.builder(
                    itemCount: storiesProvider.stories.length,
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 14.h),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      QuranStories model = storiesProvider.stories[index];
                      return InkWell(
                        onTap: () {
                          if (network == 1) {
                            Future.delayed(
                                Duration.zero,
                                () => context
                                    .read<RecitationPlayerProvider>()
                                    .pause(context));
                            storiesProvider.gotoStoryPlayerPage(
                                model.storyId!, context, index);
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                  const SnackBar(content: Text("No Internet")));
                          }
                        },
                        child: Container(
                          width: 209.w,
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/quran_stories/${model.image!}"),
                                  fit: BoxFit.cover)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(0, 0, 0, 1),
                                ],
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 6.w, bottom: 8.h, right: 6.w),
                              alignment: language.locale.languageCode == "ur" ||
                                      language.locale.languageCode == "ar"
                                  ? Alignment.bottomRight
                                  : Alignment.bottomLeft,
                              child: Text(
                                localeText(context, model.storyTitle!),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontFamily: "satoshi",
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
