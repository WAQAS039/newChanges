import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/localization/localization_constants.dart';
import '../../../shared/routes/routes_helper.dart';
import '../../basics_of_quran/models/islam_basics.dart';
import '../../basics_of_quran/provider/islam_basics_provider.dart';
import '../../quran/pages/recitation/reciter/player/player_provider.dart';
import 'home_row_widget.dart';

class IslamBasicsSection extends StatelessWidget {
  const IslamBasicsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    int network = Provider.of<int>(context);
    return Column(
      children: [
        HomeRowWidget(
          text: localeText(context, 'islam_basics'),
          buttonText: localeText(context, "view_all"),
          onTap: () {
            Navigator.of(context).pushNamed(RouteHelper.basicsOfQuran);
          },
        ),
        Consumer<LocalizationProvider>(
          builder: (context, language, child) {
            return SizedBox(
              height: 136.h,
              child: Consumer<IslamBasicsProvider>(
                builder: (context, islamBasicProvider, child) {
                  return ListView.builder(
                    itemCount: islamBasicProvider.islamBasics.length,
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 14.h),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      IslamBasics islamBasics =
                          islamBasicProvider.islamBasics[index];
                      return InkWell(
                        onTap: () async {
                          if (network == 1) {
                            Future.delayed(
                                Duration.zero,
                                () => context
                                    .read<RecitationPlayerProvider>()
                                    .pause(context));
                            islamBasicProvider.gotoBasicsPlayerPage(
                                islamBasics.title!, context, index);
                            analytics.logEvent(
                              name: 'islam_basics_title_tapped',
                              parameters: {'title': islamBasics.title},
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                  const SnackBar(content: Text("No Internet")));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                  image: AssetImage(islamBasics.image!),
                                  fit: BoxFit.cover)),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 6.w, bottom: 8.h, right: 6.w),
                            alignment: language.locale.languageCode == "ur" ||
                                    language.locale.languageCode == "ar"
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            child: Text(
                              localeText(
                                  context, islamBasics.title!.toLowerCase()),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  fontFamily: "satoshi",
                                  fontWeight: FontWeight.w900),
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
